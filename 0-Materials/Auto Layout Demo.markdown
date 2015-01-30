# Session 103: Auto Layout

In this demo, we'll cover the basics of auto layout by building a three-column interface. We'll be working in Interface Builder during the demo, and then you'll switch over to some code in the lab and challenge.

If you fall behind during the live demo, you can catch up with the steps here. Otherwise, there's a completed demo project you can load up so you can get right into the lab.

## Getting started

Open **Main.storyboard** and scroll over to the view controller. During this demo, we'll be doing everything in Interface Builder.

Here's what the final layout will look like:

![](assets/demo-completed.png)

## Top view

Drag a view to the view controller. Since it's a white view on a white background by default, set the view's background color to a nice green so it's visible. In the document outline, change the view's name to **Top View**.

In the size inspector, set the view's origin to **(0,0)** to position it in the top-left corner. Set the width to 600 and the height to 200.

Now to add the first constraint! Make sure the view is selected and click the Pin button at the bottom-right of the screen.

![](assets/demo-pin.png)

Uncheck **Constrain to margins** and select the top, left, and right constraints. The values should all be 0. Click **Add Constraints** to continue.

There's a missing constraint and auto layout should be complaining about not knowing the height of the top view. Select the top view and navigate to **Editor \ Pin \ Height** to add the missing height constraint.

Next, drag a label onto the top view. Set its text to **RWDevCon** and set its font to **System Bold**, 24 points. The label is too small to show the entire text at that size, so navigate to **Editor \ Size to Fit Content** and the label will snap to the perfect size to fit the text.

Now position the label so it's exactly in the center of the top view. The guides will help you get the label centered both horizontally and vertically.

The relationship here will be to place the label in the center of the top view. Control-drag from the label to the top view (this might be easier to do from the document outline) and select both **Center Horizontally in Container** and **Center Vertically in Container**.

## Bottom container

Next are the three columns underneath the top view. To create a better hierarchy, you'll add one container under the top view to take up all that space and then add three subviews in there, one for each column.

Drag a new view underneath the top view. Set its background color to dark grey so it's visible and set its name to **Container View**.

This time, you'll set the constraints first rather than position the view first. Select the view and click the pin button. Uncheck **Constrain to margins** and select the top, bottom, left, and right constraints. Set all the values to 0.

Click **Add 4 Constraints** to continue. You'll see some orange lines saying the view's current frame doesn't match the constraints.

To fix, select the view and navigate to **Editor \ Resolve Auto Layout Issues \ Update Frames**. The grey view should take up the entire space underneath the top view.

## Column views

Now for the three columns. Drag a view onto the container view and resize it so takes up the entire height of the container. Make the width narrow, around 100 points wide.

Copy and paste this view twice to make the three colums. To make the center column stand out more, change its background color to light grey.

Position the left view right up against the left edge, and the right view right up against the right edge. You should have three colums – white, light grey, white – with the dark grey showing up behind.

![](assets/demo-columns.png)

Name the left column **Beginner View**, the center column **Intermediate View** and the right column **Advanced View**.

## Column constraints

Now for the constraints! Pin the beginner view to the top, left, and bottom. Make sure **Constrain to margins** is unchecked. The three values should be 0.

For vertical positioning, control-drag from the beginner view to the intermediate view. Select both **Top** and **Bottom** so the intermediate view will just copy the top and bottom alignment of the beginner view. Do the same for the advanced view: control-drag from the beginner view to the advanced view and select both **Top** and **Bottom**.

For horizontal positioning, you want the three columns to be equal widths. Again, control-drag from the beginner view to the intermediate view and select **Equal Width**. Do the same for the advanced view.

Finally, there's the horizontal positioning: you want the three columns to be right up against each other with no space in between. Control-drag from the beginner view to the intermediate view and add a **Horizontal Spacing** constraint. Edit the constant of this constraint to be 0.

Similarly, control-drag from the intermediate view to the advanced view and add a **Horizontal Spacing** constraint. Edit the constant of this constraint to be 0.

There's one constraint left: pin the advanced view to the trailing edge. Make sure **Constrain to margins** is unchecked and the value is 0.

That should be all the information auto layout needs! Navigate to **Editor \ Resolve Auto Layout Issues** and select **Update Frames** under **All Views in View Controller**.

<!--
Change beginner bottom/top – see how the change cascades
Preview
-->

## Top view height

Finally, that fixed 200-point height on the top view doesn't look so good on small screens in landscape. Find the height constraint and delete it.

Control-drag from the top view to its parent, the top level view (this will also be easier to do in the document outline). Add an **Equal Height** constraint.

Find that constraint and open the size inspector. Make sure the relationship is **Top View.Height** is Equal to **Superview.Height** rather than the other way around. Change the multiplier to 0.15.
