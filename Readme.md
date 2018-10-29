Thrive Code Challenge. 

Third party libraries used:

-Alamofire for Networking

-SwiftyJson for Json parsing

Design pattern used:

    -MVC

Communicaton patterns used:

    -Delegation
    -Notifications
    
    
Project Requirements:
        The app should allow users to create a book:
            - Click the add book button and complete the form on the following screen
        The app should allow users to update a book information:
            - Select a book from the library and check it out from the detail screeen
        The app should allow users to delete a specific book]:
            -Slide to delete a book from the library
        The app should allow users to delete all books at once:
            - Click the trash can icon in the top right of the Home screeen
        

        
With more time I would:
-Add view animations that keeps the buttons visible rather than hiding them behind the keyboard
        -(Currently handled with tap gesture recognizers/ Text Field Delegates)
-Handle networking errors more explicity I.e. if it times out, create an alert to present to the user
-Convert the dates provided in JSON to a more legible format before presenting it to the user
-Take some of the code that generates views out of the view controllers and place them in their own files to make the code cleaner


