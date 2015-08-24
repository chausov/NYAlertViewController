//
//  DemoViewController.m
//  NYAlertViewDemo
//
//  Created by Nealon Young on 7/18/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "DemoViewController.h"

#import <MapKit/MapKit.h>
#import "NYAlertViewController.h"

@interface DemoViewController ()

- (void)showStandardAlertView;
- (void)showCustomAlertViewWithActionCount:(NSInteger)actionCount;
- (void)showMapViewAlertView;
- (void)showDatePickerAlertView;
- (void)showLongMessageAlertView;
- (void)showCustomUIAlertView;

@end

static NSString * const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
}

- (void)showStandardAlertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Example Title", nil)
                                                                             message:NSLocalizedString(@"Nullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum. Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.", nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    alertController.view.tintColor = self.view.tintColor;
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Destroy", nil)
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showCustomAlertViewWithActionCount:(NSInteger)actionCount {
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = NSLocalizedString(@"Example Title", nil);
    alertViewController.message = NSLocalizedString(@"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);
    
    alertViewController.view.tintColor = [UIColor greenColor];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    for (int i = 0; i < actionCount; i++) {
        NSString *actionTitle = [NSString stringWithFormat:NSLocalizedString(@"Action %d", nil), i + 1];
        UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;
        
        // Set up the final action as a cancel button
        if (i == actionCount - 1) {
            actionTitle = NSLocalizedString(@"Cancel", nil);
            actionStyle = UIAlertActionStyleCancel;
        }
        
        [alertViewController addAction:[NYAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(NYAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showMapViewAlertView {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Delete", nil)
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    alertViewController.title = NSLocalizedString(@"Content View", nil);
    alertViewController.message = NSLocalizedString(@"Set the alertViewContentView property to add custom views to the alert view", nil);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    [mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    mapView.zoomEnabled = NO;
    mapView.scrollEnabled = NO;
    mapView.layer.cornerRadius = 6.0f;
    
    CLLocationCoordinate2D infiniteLoopCoordinate = CLLocationCoordinate2DMake(37.331693, -122.030457);
    mapView.region = MKCoordinateRegionMakeWithDistance(infiniteLoopCoordinate, 1000.0f, 1000.0f);
    [contentView addSubview:mapView];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapView(160)]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(mapView)]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[mapView]-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(mapView)]];
    
    alertViewController.alertViewContentView = contentView;
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showDatePickerAlertView {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.title = NSLocalizedString(@"Content View", nil);
    alertViewController.message = NSLocalizedString(@"Set the alertViewContentView property to add custom views to the alert view", nil);
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Select", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    alertViewController.alertViewContentView = datePicker;
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showLongMessageAlertView {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];

    alertViewController.title = NSLocalizedString(@"Long Message", nil);
    alertViewController.message = NSLocalizedString(@"Nullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum. Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Donec id elit non mi porta gravida at eget metus. Etiam porta sem malesuada magna mollis euismod. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec ullamcorper nulla non metus auctor fringilla. Nullam quis risus eget urna mollis ornare vel eu leo. Etiam porta sem malesuada magna mollis euismod. Maecenas faucibus mollis interdum. Maecenas sed diam eget risus varius blandit sit amet non magna.", nil);
    
    alertViewController.alertViewBackgroundColor = [UIColor blueColor];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showCustomUIAlertView {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];

    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"Lorem ipsum", nil);
    alertViewController.message = NSLocalizedString(@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vitae urna eu est lobortis luctus.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vitae urna eu est lobortis luctus.", nil);
    
    alertViewController.buttonCornerRadius = 0.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"Arial" size:20.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"Arial" size:15.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"Arial" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"Arial" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 0.0f;
    
    alertViewController.titleColor = [UIColor redColor];
    alertViewController.messageColor = [UIColor blackColor];
    
    alertViewController.buttonColor = [UIColor whiteColor];
    alertViewController.buttonTitleColor = [UIColor blackColor];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showTextFieldAlertView {
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"Lorem ipsum", nil);
    //    alertViewController.message = NSLocalizedString(@"You will receive a cashout email reciept immediately. Payments take up to 24 hours.\n\nIf you need to make changes to your paypal address, please email cashout@beomni.com", nil);
    
    NSMutableAttributedString *msgString = [[NSMutableAttributedString alloc] init];
    
    NSString *regularPart = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vitae urna eu est lobortis luctus.\n\n";
    
    NSDictionary *textGrayTitleAttribs = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:15.0],
                                           NSForegroundColorAttributeName: [UIColor blackColor]
                                           };
    
    NSDictionary *textBoldTitleAttribs = @{
                                           NSFontAttributeName :[UIFont italicSystemFontOfSize:15.0],
                                           NSForegroundColorAttributeName: [UIColor blackColor]
                                           };
    
    
    [msgString appendAttributedString:[[NSAttributedString alloc] initWithString:regularPart
                                                                      attributes:textGrayTitleAttribs]];
    
    
    
    NSString *string = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vitae urna eu est lobortis luctus. ";
    
    [msgString appendAttributedString:[[NSAttributedString alloc] initWithString:string
                                                                      attributes:textBoldTitleAttribs]];
    
    
    
    
    alertViewController.attributedMessage = msgString;
    
    
    alertViewController.buttonCornerRadius = 0.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"Arial" size:20.0f];
    //    alertViewController.messageFont = [UIFont fontWithName:@"Arial" size:15.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"Arial" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"Arial" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithRed:230.0/255.0 green:232.0/255.0 blue:233.0/255.0 alpha:1.0];
    alertViewController.alertViewCornerRadius = 0.0f;
    
    alertViewController.titleColor = [UIColor blackColor];
    //    alertViewController.messageColor = [UIColor blackColor];
    
    alertViewController.buttonColor = [UIColor whiteColor];
    alertViewController.buttonTitleColor = [UIColor blackColor];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITextField *_textField = [[UITextField alloc] initWithFrame:CGRectZero];
    [_textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.spellCheckingType = UITextSpellCheckingTypeNo;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.keyboardType = UIKeyboardTypeEmailAddress;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.placeholder = @"Lorem ipsum";
    
    _textField.layer.borderColor = [UIColor colorWithRed:152.0/255.0 green:164.0/255.0 blue:174.0/255.0 alpha:1.0].CGColor;
    _textField.layer.borderWidth = 1.0;
    
    [contentView addSubview:_textField];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_textField(40)]-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(_textField)]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-26-[_textField]-26-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(_textField)]];
    
    alertViewController.alertViewContentView = contentView;
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Continue", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self showCustomAlertViewWithActionCount:0];
            break;
            
        case 1:
            [self showCustomAlertViewWithActionCount:1];
            break;
            
        case 2:
            [self showCustomAlertViewWithActionCount:2];
            break;
            
        case 3:
            [self showCustomAlertViewWithActionCount:3];
            break;
            
        case 4:
            [self showMapViewAlertView];
            break;
            
        case 5:
            [self showDatePickerAlertView];
            break;
            
        case 6:
            [self showLongMessageAlertView];
            break;
            
        case 7:
            [self showCustomUIAlertView];
            break;
            
        case 8:
            [self showTextFieldAlertView];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
