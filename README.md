# MRPopOverVC

To use this, simply download the whole project and drag and drop the MRPopOver group folder to your own project.
There are three ways you can use this project. 

**NOTE:** This does not support orientation changes. That part you will have to handle on your own. Also ensure that you create the provided pop overs **after** calling animations on the view pop up appears from or animate the pop over along with the button.

## First - Present a pop over with a view controller
You can show a view controller from any view of that you decided. It will adjust itself to fit across the whole width and 
remaining height. If the view from which you wish to display the pop over is present in the top part of the screen, the pop over will appear from the view all the way to the bottom of the screen. If the view is present in the bottom half of the screen, the pop over will appear from the view to the top part of the screen. Have a look at the screenshot:

![alt tag](http://i.imgur.com/WllEUy0.png) ![alt tag](http://i.imgur.com/gub8IzR.png) ![alt tag](http://i.imgur.com/mQ6X3VE.png) 

###### Use the below code segment to show the pop over:
    
    //instantiate whichever view controller you wish to show
    UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"table"];
    
    MRPopOverViewController *viewControllerNew = [[MRPopOverViewController alloc] initFromView:sender withViewController:viewController];

    [self presentViewController:viewControllerNew animated:YES completion:nil];

###### Some additional properties that allow you to customize the pop over:

    @property (strong, nonatomic) UIColor *trianglePopUpColor;
    @property (strong, nonatomic) UIColor *colorOfBorder;
    @property (assign, nonatomic) CGFloat borderWidth;
    @property (assign, nonatomic) CGFloat cornerRadiusForPopOver;
    @property (assign, nonatomic) CGFloat shadowRadius;
    @property (strong, nonatomic) UIColor *shadowColor;
    @property (assign, nonatomic) CGSize shadowOffset;
    @property (assign, nonatomic) CGFloat shadowOpacity;

    @property (assign, nonatomic) UIEdgeInsets edgeInsets;
    @property (assign, nonatomic) CGFloat triangleWidth;
    @property (assign, nonatomic) NSNumber *totalHeight;

###### Also there is a delegate to notify you whenever the user decides he wants to close the screen by tapping outside:

Just make your class conform to the `MRPopOverViewControllerDelegate` and set it using:

    viewControllerNew.delegate = self;

To peform some action just write the function inside your class:

    -(void)userDidDismissViewController;

**Note:** Set the `triangleWidth`, `edgeInsets`, `totalHeight` properties before presenting the view controller. Otherwise it won't work as they cannot be modified at run time(yet?).  You will have to recreate the pop over view controller if you want to change either of the 3 mentioed properties at run time after deallocation the previous instance :D.

**Note:** If you add a total height, the pop over will ignore the edge inset of the side on which the popover is displayed. For example if the popover appears on top, the top edge inset will be ignored. 

## Second - Present a pop over with a string from a view
You can present a pop over from any view of your choice and display a pop up with a text string. (Sort of like facebook tutorials). Have a look at the attached screenshot.

![alt tag](http://i.imgur.com/IXx95SC.png) ![alt tag](http://i.imgur.com/RfcrHtW.png) 

###### Use the below code segment to add the pop over:
    
    MRPopOverView *labelView = [[MRPopOverView alloc] init];
    
    [labelView createInfoBelowView:sender withString:@"Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?" andFont:nil];
    
    [self.view addSubview:labelView];

###### Additional customization properties:

    @property (assign, nonatomic) CGFloat labelBorderWidth;
    @property (strong, nonatomic) UIColor *labelBackgroundColor;
    @property (strong, nonatomic) UIColor *labelTextColor; 
    @property (strong, nonatomic) UIColor *textBorderColor; 
    @property (assign, nonatomic) CGFloat triangleWidth;

**Note:** Set the `triangleWidth` property before presenting the view controller. Otherwise it won't work.

**Note:** Similar to the view controller, there is a delegate to notify you when user dismisses the label called `userDidDismissView`

## Third - Present a pop over with a string from an array of coordinates
This is similar to the previous way of implementation with only the difference that instead of passing a view to display a string, you can pass an array of dictionaries containing coordinates and text for each label. 

![alt tag](http://i.imgur.com/Lv1LLzI.png) ![alt tag](http://i.imgur.com/q3oAR3A.png) 

###### Use the below code segment to add the pop over:
    
    MRPopOverView *labelView = [[MRPopOverView alloc] init];
       
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"How ya doin?Heyyyyyy!",@"text",@(sender.center.x),@"xCoordinate", @(sender.center.y), @"yCoordinate",sender.superview,@"viewToBeMadeIn",nil];
    
    NSArray *array = [[NSArray alloc] initWithObjects:dict, nil];
    
    [labelView createInfoWithPointsAndTextDictionaryArray:array andFont:nil];

    [self.view addSubview:labelView];

**Note:** The additional properties are same as above.
