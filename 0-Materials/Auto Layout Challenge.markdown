# Session 103: Auto Layout Challenge

You’re now familiar with all kinds of ways to add constraints – from buttons, menus, dragging between views, code, and the visual format language. You’re well on your way to creating even more interesting layouts for your apps!

In this challenge, you’ll reproduce one more view controller for the **About RWDevCon** app from a screenshot.


## Another view controller

Open the storyboard and drag out another view controller.


![](assets/challenge-vc.png)
 
Just in case you want to test the new view controller on device, you can connect a segue from one of the buttons. Control-drag from the beginner (bicycle) button to your new view controller.


![](assets/challenge-segue.png)

In the popup, select **Show** in the **Action Segue** heading.


Now when you run the app, you can tap on the bicycle to show the second view controller.


## Target design

Here’s what the view controller should look like, in a few sizes and interface orientations from the assistant editor preview:

![](assets/challenge-sample1.png)

![](assets/challenge-sample2.png)

![](assets/challenge-sample3.png)

![](assets/challenge-sample4.png)

You’ll find the required images in the asset catalog: **beginner** for the bicycle icon and **rwdevcon-challenge** for the logo. The bicycle icon is 57x57 (you should give it a fixed size constraint) and the RWDevCon logo is 90x90.

Also, here’s the text to paste into the label:

> This track is for those who are beginners to iOS development, or beginners on the listed topic. We will be sending you some required reading before the conference. If you are a beginner, be sure to do this required reading or some of these talks will go over your head!

I’d suggest building this in interface builder but if you want an über challenge (not for the faint of heart!), add a new class for the second view controller and build it in code!

There are a few hints below if you need some help along the way. For a sample solution, check out the resources for this session. You’ll find an Xcode project with the view controller built out in the storyboard.

## Hints

Here are some hints, going from top to bottom in the layout.

1. Note that the RWDevCon icon, “The Beginner Track” label, and the bicycle are all Center Y aligned. That is, you could draw a straight horizontal line through their centers.

2. Remember intrinsic content size? Images in image views have that too! Once you set the image, just hit Command-= or **Editor \ Size to Fit Content**. You should still add fixed width and height constraints once the image view is the proper size.

3. The “The Beginner Track” label has its leading and trailing space to its neighbors set to keep it between the two images. The label has its number of lines set to 0 so it can wrap nicely if needed.

    Note that if you set the label to be centered horizontally in its superview, the label text might overlap the images on either side if you test in some iPhone sizes.

4. The blurb of text is vertically centered in the superview. It also has its number of lines set to 0 so it can wrap nicely.

