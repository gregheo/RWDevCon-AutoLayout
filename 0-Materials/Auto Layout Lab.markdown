# Session 103: Auto Layout Lab

You’ve seen how to set up your auto layout constraints from interface builder. Now it’s time to apply that knowledge and try adding layout constraints from code!

Layout constraints are just objects that you can create and attach to views. You can even connect constraints in your storyboard as outlets to your code, and modify them at runtime!

In this short lab, you’ll create some new views and then lay them out with constraints from code.

## Getting started

Open the Lab starter project. There are a few additions to the interface in **Main.storyboard** since the end of the demo:

* A "Details" button in the top view with a touch-up-inside action connected to `detailsButtonTapped()`
* Three image buttons, one in each column

![](assets/lab-starter.png)

The constraints for these views are the same ones you're already used to: centered in container, top space, and trailing space.

There are also outlets connected to `ViewController`:

* Outlets for each column view: `beginnerView`, `intermediateView`, and `advancedView`
* Outlets for each button: `beginnerButton`, `intermediateButton`, and `advancedButton`

You’ll need these outlets to add the constraints to the containers, and to position the new views you’ll be adding relative to the buttons.

The image buttons don't have actions connected. In the final app the buttons might push something onto the navigation stack to show the sessions for each conference track but that's left as an exercise (or challenge) for the reader since it doesn't relate to auto layout directly. ;]

## Manual constraint relationships

Open **ViewController.swift** and add the following properties to the class:

```swift
var advancedLabel: UILabel!
var intermediateLabel: UILabel!

var advancedVerticalConstraint: NSLayoutConstraint!

let verticalMargin: CGFloat = 8.0
```

You’ll be adding new labels to the interface from code to show a description of the track. You’ll also want to hold a reference to one of the layout constraints, `advancedVerticalConstraint`, to modify it later.

Finally, `verticalMargin` is a constant that you’ll use to keep the spacing consistent.

Next, add the following helper method to the class:

```swift
private func addAdvancedLabel() {
  // 1
  advancedLabel = UILabel()
  advancedLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  advancedLabel.text = "Dive deep into a guided tour of more advanced topics like functional programming, Scene Kit, and more!"
  advancedLabel.numberOfLines = 0
  advancedView.addSubview(advancedLabel)

  // 2
  advancedVerticalConstraint = NSLayoutConstraint(
    item: advancedLabel,
    attribute: .Top,
    relatedBy: .Equal,
    toItem: advancedButton,
    attribute: .Bottom,
    multiplier: 1.0,
    constant: verticalMargin)
  advancedVerticalConstraint.active = true

  // 3
  let leadingConstraint = NSLayoutConstraint(
    item: advancedLabel,
    attribute: .Leading,
    relatedBy: .Equal,
    toItem: advancedView,
    attribute: .LeadingMargin,
    multiplier: 1.0,
    constant: 0)
  leadingConstraint.active = true

  // 4
  let trailingConstraint = NSLayoutConstraint(
    item: advancedLabel,
    attribute: .Trailing,
    relatedBy: .Equal,
    toItem: advancedView,
    attribute: .TrailingMargin,
    multiplier: 1.0,
    constant: 0)
  trailingConstraint.active = true
}
```

This method will create a new label and set up its size and position with layout constraints. Here’s what’s going on, section by section:

1. Create a new label, set its properties, and add it to the view. Note the call to `setTranslatesAutoresizingMaskIntoConstraints(false)` – if you’re setting up constraints in code, you need to be sure to call this method on your view so that it doesn’t automatically create a default set of constraints. These constraints would conflict with your own, so you need to call this method to ensure you’re starting off with a clean slate.

    Since the text is long, you’re setting the label’s number of lines to 0. This means the label will grow and add lines to fit the text.
  
2. Here’s your first code constraint! You’re saving this one to the `advancedVerticalConstraint` property so you can adjust it later. Notice how the initializer parameters for `NSLayoutConstraint` match what you see when you edit a constraint from interface builder – the two items, the relationship, a multipler, and a constant.

    In this case, you’re saying the position of the top of the label should be equal to the position of the bottom of the button. The constant is set to `verticalMargin`, so you’ll get an 8-point vertical margin between the button and the label.

3. This constraint is for the leading (left) space between the label and its superview. You’re relating the leading edge of the label to the leading margin of the superview.

4. The final constraint is similar to the previous one; this one is for the trailing (right) space between the label and its superview. You’re relating the trailing edge of the label to the trailing margin of the superview.


After creating each constraint, you set its active property to true, which will install the constraint into the correct view. Before iOS 8, you had to add the constraint manually to the correct view; notice how much easier that is now with just a single Boolean property!

That’s all you need! The label is set to 0 lines so it will automatically grow vertically to fit the amount of text. The constraints give the label its x- and y-positions, so you shouldn’t have any layout ambiguity.

Add the following lines to `detailsButtonTapped()`:

```swift
if advancedLabel == nil {
  addAdvancedLabel()
}
```

This will call the helper method to set up the label.

Build and run, and tap the Details button. You should see the label appear in the correct spot. If you rotate the device or simulator, you’ll see the label resize properly to fit the constraints.

![](assets/lab-label1.png)
 
## Visual format language

Creating `NSLayoutConstraint` instances one at a time works but can be a lot of code. Instead, you can use the **visual format language**, which is an ASCII-art style way to define your layout constraints.

Here’s an example of the visual format language:

```
H:|-8-[myButton(90)]-20-[topLabel]-8-|
```

The “H:” at the beginning means this is a representation of the horizontal layout.

The vertical bar characters represent the outer bounds of the superview. The numbers surrounded by minus signs are the margins between views. The named elements in square brackets are the views themselves.

So this means `myButton` would be 90 points wide, and have 8 points of leading space to the superview. Then there would be a 20 point margin to `topLabel`, and then 8 points from the trailing edge of topLabel to the superview.
 
 ![VFL decoded](assets/lab-vfl.png)
 
You would then need a similar bit of VFL for the vertical constraints.

Let’s see this in real life. Add the following helper method to the class to set up the intermediate track label:

```swift
private func addIntermediateLabel() {
  intermediateLabel = UILabel()
  intermediateLabel.setTranslatesAutoresizingMaskIntoConstraints(
    false)
  intermediateLabel.text = "This track is for Objective-C developers who are not yet fully up-to-speed with Swift."
  intermediateLabel.numberOfLines = 0
  intermediateView.addSubview(intermediateLabel)

  // 1
  let views = ["intermediateLabel": intermediateLabel,
    "intermediateView": intermediateView,
    "intermediateButton": intermediateButton]
  let metrics = ["margin": 4, "verticalMargin": verticalMargin]

  // 2
  let horizontalConstraints =
    NSLayoutConstraint.constraintsWithVisualFormat(
      "H:|-margin-[intermediateLabel]-margin-|",
      options: nil, metrics: metrics, views: views)
  // 3
  let verticalConstraints =
    NSLayoutConstraint.constraintsWithVisualFormat(
      "V:[intermediateButton]-verticalMargin-[intermediateLabel]",
      options: nil, metrics: metrics, views: views)

  // 4
  NSLayoutConstraint.activateConstraints(
    horizontalConstraints + verticalConstraints)
}
```

The first bit of code is similar to the advanced label in setting up the UILabel and its properties. Things get a little different after that point:

1. In the sample VFL you saw names like “myButton” in there, but how does iOS know which view has which name? This is where you set that up! You can pass in a dictionary to map strings to view objects, so that’s what you’re setting up here.

    You can do a similar thing with metrics; rather than hard-code numbers, you define another dictionary with numeric values that you can refer to later.

2. Here are the first set of visual format language constraints. This is a horizontal constraint that will center the label horizontally in the superview, with 4-point leading and trailing margins.

3. The vertical constraint here sets the y-position of the label. Since the button’s position is already set, you don’t need to refer to the superview. Instead, you’re setting the label to be 8 points (that’s the `verticalMargin`) below the button.

4. If you have many constraints to add at the same time, you can pass in an entire array of `NSLayoutConstraint` objects to the `activateConstraints` class method. This is more efficient than setting each individual constraint to `active` one at a time.


Note that `constraintsWithVisualFormat()` has an “s” at the end of the word constraints since it returns an array of constraints. You could have a whole set of views in your VFL string, so one string could map to many constraints. You can see how this can be much more efficient than creating `NSLayoutConstraint` objects one at a time as you did for the advanced label!

Now that the helper method is set up, update `detailsButtonTapped()` to add the new method call:

```swift
if advancedLabel == nil {
  addAdvancedLabel()
  addIntermediateLabel()
}
```

Build and run, tap the Details button, and you’ll see both labels in place!


![](assets/lab-label2.png)

## Modifying constraints

Tapping the Details button will show the labels, but it tapping it again doesn't do anything. It makes sense for the button to actually toggle the labels on and off.

Add the following helper method to toggle the two labels on and off:

```swift
private func toggleLabel() {
  if intermediateLabel.alpha == 0 {
    intermediateLabel.alpha = 1
    advancedVerticalConstraint.constant = verticalMargin
  } else {
    intermediateLabel.alpha = 0
    advancedVerticalConstraint.constant =
      CGRectGetHeight(advancedView.frame)
  }
}
```

For the intermediate label, you’re changing the alpha to 1 to show it, and 0 to hide it.

For the advanced label, you saved its vertical position constraint when you set it up. To show the label, you’re changing the constant to its initial value of `verticalMargin`, currently 8.0. Remember, that’s the y-position for the number of points below the button.

To hide the label, you’re setting the constant to the height of the container frame. That will push the label down below the bounds of the screen and effectively hide it.

In this case, the effect is the same so the labels will just show and hide as you'd expect. So why might you use the constraint method? Changing the alpha vs changing the position could make a difference if there were **animations** involved. *That's a subtle hint about an upcoming RWDevCon session. ;]*

Finally, update the implementation of `detailsButtonTapped()` with the following:

```swift
if advancedLabel == nil {
  addAdvancedLabel()
  addIntermediateLabel()
} else {
  toggleLabel()
}
```

If this is the first button tap, the method will add the two labels to the view. On subsequent taps, the method will call `toggleLabel()` instead.

Build and run the app, and tap the Details button a few times. You’ve now created constrains two different ways from code, and also updated an existing constraint on the fly!

## Where to go from here?

You’ve seen many different ways to set up auto layout constraints: the Pin button on your storyboard, from the menu, control-dragging between views, and from code. iOS offers many ways for you to customize and modify your layout and you should take advantage of this flexible technology to get your apps looking good on all screen sizes.

There’s still one more challenge ahead in this session! Given a screenshot of a completed view, you’ll need to create and lay it out from scratch. Check out the challenge document for all the details!
