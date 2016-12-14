# File Viewer Plugin

Leverage your hybrid applications to open documents in a preview mode or with an external application.

This plugin defines a global ( `cordova.plugins.DocumentPreview` ) object which you can use to access the public API.


## Plugin

Although `DocumentPreview` is globally acessible, it isn't usable until `deviceready` event is called.

As with all the cordova plugins, you can listen to `deviceready` event as follows: 

```javascript
document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() {
    // ...
}
```

## Supported Platforms

 - iOS
 - Android 


## Installation
- Run the following command:

```shell
    cordova plugin add https://github.com/OutSystemsExperts/File-Viewer-Plugin.git
``` 
---

## API Reference

### DocumentPreview (`cordova.plugins.DocumentPreview`)

 - [`.openDocument(filePath, fileMIMEType, previewDoc, successCallback, errorCallback)`](#openDocument)
 
---

<a name="openDocument"></a>
#### Open Document

Calling this method opens the documents. Document can be open inside of the application with the preview mode or in an external application.

| Param             | Type      | Description |
| ---               | ---       | --- |
| successCallback   | [`Function`](#successCallback)  | Callback function called when successfully open document. |
| errorCallback     | [`Function`](#errorCallback)    | Callback function called when an error occurs |
| filePath     | String    | Path to file in file system. |
| fileMIMEType     | String    | Mime Type of document. |
| previewDoc     | Boolean    | True if the document should be open in preview mode or False to open with external app. |

<a name="successCallback"></a>
#### Success Callback

Signature: 

```javascript
function(){
    // ...
};
```

<a name="errorCallback"></a>
#### Error Callback

Signature: 

```javascript
function(err){
    // ...
};
```

where `err` parameter is a JSON object:

```javascript
{
    "error_code":"",
    "error_message":""
}
```

Possible `error_code` values:

 - `OS_INVALID_ARGS` - Integer Value 1. Invalid arguments were given.
 - `INVALID_PATH` - Integer Value 2. Invalid path to open.
 - `NO_APPLICATION` - Integer Value 5. There aren't Applications to open this document.

---

## Support

This plugin is not supported by OutSystems. You may use the [discussion forums](https://www.outsystems.com/forums/) to leave suggestions or obtain best-effort support from the community, including from OutSystems Experts who created this component.

#### Contributors
- OutSystems - Mobility Experts

#### Document author
- Vitor Oliveira, <vitor.oliveira@outsystems.com>

###Copyright OutSystems, 2016

---

LICENSE
=======


[The MIT License (MIT)](http://www.opensource.org/licenses/mit-license.html)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
