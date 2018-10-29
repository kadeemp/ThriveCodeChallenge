Thrive Code Challenge. 


Third party libraries used:

-Alamofire for Networking

-SwiftyJson for Json parsing

Design pattern used:

-MVC

Communicaton patterns used:
    -Observer
        -Delegation
        -Notifications
        
        
With more time I would:
-Add view animations that keeps the buttons visible rather than hiding them behind the keyboard
        -(Currently handled with tap gesture recognizers)
-Handle networking errors more explicity I.e. if it times out, create an alert to present to the user
-Convert the dates provided in JSON to a more legible format before presenting it to the user
-Take some of the code that generates views out of the view controllers and place them in their own files to make the code cleaner


