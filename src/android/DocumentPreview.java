package com.outsystems.documentpreview;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.webkit.URLUtil;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;

/**
 * This class echoes a string called from JavaScript.
 */
public class DocumentPreview extends CordovaPlugin {

    private final static String KEY_ACTION_OPEN_DOCUMENT = "openDocument";

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals(KEY_ACTION_OPEN_DOCUMENT)) {
            openDocument(args, callbackContext);
            return true;
        }
        return false;
    }

    private void openDocument (JSONArray args, CallbackContext callbackContext) throws JSONException {
        String filePath = args.getString(0);
        String fileMIMEType = args.getString(1);
        String previewDocument = args.getString(2);

        if(filePath != null || filePath.length() > 0) {

            // Check if it's a video
            if (fileMIMEType.contains("video")){
                openVideoPlayer(filePath, fileMIMEType);
                callbackContext.success();
                return;
            }
            // Check if it's a url instead of file path
             if(URLUtil.isValidUrl(filePath) && (filePath.contains("http://") || filePath.contains("https://"))){
                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(filePath));
                cordova.getActivity().startActivity(browserIntent);
                callbackContext.success();
                return;
            }

            openDocumentLocalApp(filePath, fileMIMEType);
            callbackContext.success();
            return;
        }

        callbackContext.error("Invalid path to open");
    }

    private void openVideoPlayer(String filePath, String fileMIMEType) throws ActivityNotFoundException {
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(Uri.parse(filePath), "application/pdf"); //"application/pdf"
        intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
        cordova.getActivity().startActivity(intent);
    }

    private void openDocumentLocalApp (String filePath, String fileMIMEType)throws ActivityNotFoundException {
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(Uri.parse(filePath), fileMIMEType); //"application/pdf"
        intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
        cordova.getActivity().startActivity(intent);

    }

    private void openUrlInBrowser (String filePath) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(filePath));
        cordova.getActivity().startActivity(browserIntent);
    }
}
