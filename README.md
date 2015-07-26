# NYAlertViewController

Highly customizable replacement for UIAlertController/UIAlertView

![Example](https://github.com/nealyoung/NYAlertViewController/raw/master/header.png)

### Features
* Includes content view property for adding custom views to your alert view
* Block-based API similar to that of UIAlertController
* Support for all screen orientations and iPad screen sizes

### Installation
#### Manual
Add the files to your project manually by dragging the NYAlertViewController directory into your Xcode project.

#### CocoaPods
Add `pod 'NYAlertViewController'` to your Podfile, and run `pod install`.

### Usage
An example project is included in the NYAlertViewControllerDemo directory.

```objc
// Import the class and create an NYAlertViewController instance
#import "NYAlertViewController.h"
NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];

// Set a title and message
alertViewController.title = NSLocalizedString(@"Custom UI", nil);
alertViewController.message = NSLocalizedString(@"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);

// Customize appearance as desired


// Add alert actions
[alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Done", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(NYAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];

// Present the alert view controller
[self presentViewController:alertViewController animated:YES];
```

### To-Dos
* Add different transition options (fade in, slide from top, etc.)

### License
This project is released under the MIT License.
