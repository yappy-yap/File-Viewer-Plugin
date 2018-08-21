package com.outsystems.documentpreview;

import android.content.ActivityNotFoundException;
import android.content.ContentResolver;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.util.Log;
import android.webkit.URLUtil;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;


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

    private void openDocument(JSONArray args, CallbackContext callbackContext) {
        String filePath = null;
        String fileMIMEType = null;
        String previewDocument = null;
        try {
            filePath = args.getString(0);
            fileMIMEType = args.getString(1);
            previewDocument = args.getString(2);
        } catch (JSONException e) {
            callbackContext.error(buildErrorResponse(1, "Invalid arguments"));
            return;
        }
        if (filePath != null || filePath.length() > 0) {

            // Check if it's a video
            if (fileMIMEType.contains("video")) {
                openVideoPlayer(filePath, fileMIMEType);
                callbackContext.success();
                return;
            }
            // Check if it's a url instead of file path
            if (URLUtil.isValidUrl(filePath) && (filePath.contains("http://") || filePath.contains("https://"))) {
                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(filePath));
                cordova.getActivity().startActivity(browserIntent);
                callbackContext.success();
                return;
            }

            try {
                openDocumentLocalApp(filePath, fileMIMEType);
                callbackContext.success();
            } catch (ActivityNotFoundException exp) {
                callbackContext.error(buildErrorResponse(5, "There aren't Applications to open this document."));
            }
            return;
        }

        callbackContext.error(buildErrorResponse(2, "Invalid path to open"));
    }

    private void openVideoPlayer(String filePath, String fileMIMEType) throws ActivityNotFoundException {
        Intent intent = new Intent(Intent.ACTION_VIEW);

        Uri videoUri;
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
            videoUri = Uri.parse(filePath);
        } else {
            //To build the File URI property, must be removed the file protocol, if it the case
            File videoFile = new File(filePath.replace("file:///", ""));
            videoUri = FileProvider.getUriForFile(cordova.getActivity(), cordova.getActivity().getPackageName() + ".opener.provider", videoFile);
        }

        intent.setDataAndType(videoUri, fileMIMEType);
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_ACTIVITY_NO_HISTORY);
        cordova.getActivity().startActivity(intent);
    }

    private void openDocumentLocalApp(String filePath, String fileMIMEType) throws ActivityNotFoundException {
        ContentResolver cR = cordova.getActivity().getApplicationContext().getContentResolver();

        Intent intent = new Intent(Intent.ACTION_VIEW);

        Uri fileUri;
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
            fileUri = Uri.parse(filePath);
        } else {
            //To build the File URI property, must be removed the file protocol, if it the case
            File documentFile = new File(filePath.replace("file:///", ""));

            fileUri = FileProvider.getUriForFile(cordova.getActivity(), cordova.getActivity().getPackageName() + ".opener.provider", documentFile);
        }

        String mimeType = cR.getType(fileUri);
        intent.setDataAndType(fileUri, mimeType);
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_ACTIVITY_NO_HISTORY);
        cordova.getActivity().startActivity(intent);
    }

    private void openUrlInBrowser(String filePath) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(filePath));
        cordova.getActivity().startActivity(browserIntent);
    }

    private JSONObject buildErrorResponse(int errorCode, String errorMessage) {
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("error_code", errorCode);
            jsonObject.put("error_message", errorMessage);
        } catch (JSONException e) {
            Log.e("DocumentPreview", e.toString());
        }
        return jsonObject;
    }
}