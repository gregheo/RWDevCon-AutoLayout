# Session 103: Auto Layout Lab

You’ve seen how to set up your auto layout constraints from interface builder. Now it’s time to apply that knowledge and try adding layout constraints from code!

Layout constraints are just objects that you can create and attach to views. You can even connect constraints in your storyboard as outlets to your code, and modify them at runtime!

In this short lab, you’ll create some new views and then lay them out with constraints from code.


Open the Lab starter project. There are a few additions to the interface in **Main.storyboard** since the end of the demo:

* A "Details" button in the top view with a touch-up-inside action connected to `detailsButtonTapped()`
* Three image buttons, one in each column

![](assets/lab-starter.png)

The constraints for these views are the same ones you're already used to: centered in container, top space, and trailing space.

There are also outlets connected to `ViewController`:

* Outlets for each column view: `beginnerView`, `intermediateView`, and `advancedView`
* Outlets for each button: `beginnerButton`, `intermediateButton`, and `advancedButton`

You’ll need these outlets to add the constraints to the containers, and to position the new views you’ll be adding relative to the buttons.

The image buttons don't have actions connected. In the final app the buttons might push something onto the navigation stack to show the sessions for each conference track but that's left as an exercise for the reader since it doesn't relate to auto layout directly. ;]



```swift
```


Finally, `verticalMargin` is a constant that you’ll use to keep the spacing consistent.


```swift
```



    Since the text is long, you’re setting the label’s number of lines to 0. This means the label will grow and add lines to fit the text.
  



After creating each constraint, you set its active property to true, which will install the constraint into the correct view. Before iOS 8, you had to add the constraint manually to the correct view; notice how much easier that is now with just a single Boolean property!



```swift
```


Build and run, and tap the Details button. You should see the label appear in the correct spot. If you rotate the device or simulator, you’ll see the label resize properly to fit the constraints.

![](assets/lab-label1.png)
 



```
```



 ![VFL decoded](assets/lab-vfl.png)
 


```swift
```






Note that `constraintsWithVisualFormat()` has an “s” at the end of the word constraints since it returns an array of constraints. You could have a whole set of views in your VFL string, so one string could map to many constraints. You can see how this can be much more efficient than creating `NSLayoutConstraint` objects one at a time as you did for the advanced label!


```swift
```


![](assets/lab-label2.png)




```swift
```




In this case, the effect is the same so the labels will just show and hide as you'd expect. So why might you use the constraint method? Changing the alpha vs changing the position could make a difference if there were animations involved. *That's a subtle hint about another RWDevCon session. ;]*


```swift
```




