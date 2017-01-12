# MRPopOverVC

To use this, simply download the whole project and drag and drop the MRPopOver group folder to your own project.
There are three ways you can use this project. 

**NOTE:** This does not support orientation changes. That part you will have to handle on your own. Also ensure that you create the provided pop overs **after** calling animations on the view pop up appears from or animate the pop over along with the button.

##First - Present a pop over with a view controller
You can show a view controller from any view of that you decided. It will adjust itself to fit across the whole width and 
remaining height. If the view from which you wish to display the pop over is present in the top part of the screen, the pop over will appear from the view all the way to the bottom of the screen. If the view is present in the bottom half of the screen, the pop over will appear from the view to the top part of the screen. Have a look at the screenshot:
![alt tag](http://i.imgur.com/WllEUy0.png) ![alt tag](http://i.imgur.com/gub8IzR.png) ![alt tag](http://i.imgur.com/mQ6X3VE.png) 
######Use the below code segment to show the pop over:
    
```   
 //instantiate whichever view controller you wish to show
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewControllerIdentifier"];
  
    MRPopOverViewController *viewControllerNew = [[MRPopOverViewController alloc] initFromView:sender withViewController:viewController];
    
    viewControllerNew.trianglePopUpColor = [UIColor greenColor];
    
    viewControllerNew.colorOfBorder = [UIColor greenColor];

    viewControllerNew.showShadow = YES;
    
    viewControllerNew.borderWidth = 5.0f;
    
    viewControllerNew.cornerRadiusForPopOver = 5.0f;
    
    viewControllerNew.edgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);

    //pass total height if you want to, for your view to take up (In case you want it to take up a part of the screen)
    viewControllerNew.totalHeight = [NSNumber numberWithFloat:totalHeight];

    [self presentViewController:viewControllerNew animated:YES completion:nil];
```

##Second - Present a pop over with a string from a view
You can present a pop over from any view of your choice and display a pop up with a text string. (Sort of like facebook tutorials). Have a look at the attached screenshot.

![alt tag](http://i.imgur.com/IXx95SC.png) ![alt tag](http://i.imgur.com/RfcrHtW.png) 

######Use the below code segment to add the pop over:
    
    MRPopOverView *labelView = [[MRPopOverView alloc] init];
    
    labelView.labelBorderWidth = 1.0f;
    
    labelView.labelTextColor = [UIColor whiteColor];
    
    labelView.textBorderColor = [UIColor blackColor];
    
    labelView.labelBackgroundColor = [UIColor blueColor];
    
    [labelView createInfoBelowView:sender withString:@"Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?" andFont:nil];
    
    [self.view addSubview:labelView];

##Third - Present a pop over with a string from an array of coordinates
This is similar to the previous way of implementation with only the difference that instead of passing a view to display a string, you can pass an array of dictionaries containing coordinates and text for each coordinate. 

![alt tag](http://i.imgur.com/Lv1LLzI.png) ![alt tag](http://i.imgur.com/q3oAR3A.png) 

######Use the below code segment to add the pop over:
    
    MRPopOverView *labelView = [[MRPopOverView alloc] init];
    
    labelView.labelBorderWidth = 1.0f;
    
    labelView.labelTextColor = [UIColor whiteColor];
    
    labelView.textBorderColor = [UIColor blackColor];
    
    labelView.labelBackgroundColor = [UIColor blueColor];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"How ya doin?Heyyyyyy!",@"text",@(sender.center.x),@"xCoordinate", @(sender.center.y), @"yCoordinate",sender.superview,@"viewToBeMadeIn",nil];
    
    NSArray *array = [[NSArray alloc] initWithObjects:dict, nil];
    
    [labelView createInfoWithPointsAndTextDictionaryArray:array andFont:nil];

    [self.view addSubview:labelView];

