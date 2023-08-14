### useRef

In React, we often need to interact with elements in the user interface, like input fields or buttons. The useRef hook is a way to refer to these elements and access them in our code.

It's like having a bookmark that remembers the location of a specific page in a book.

Let's say you have a text input in your web page, and you want to do something with the value entered by the user. With useRef, you can create a reference to that input element and use it later to get the value.

Think about HTML and using document.getElementById('nameInput') and then are able to access that value.  This is basically what useRef does. 

First, you import useRef from the React library.
Then, you create a variable using useRef and give it a meaningful name, let's call it formRef. 
Next, you attach this reference to the specific element you want to target. In our case, it would be the form  You do this by adding a special property called `ref` to the element. So, you would add ref={formRef} to the form.
Now that you have a reference to the form, we can access its properties and values using formRef.current. For example, you can get the values entered by the user with myForm.current
 useRef is a way to create a reference to an element in the user interface. It allows you to access and manipulate that element later in your code. It's like having a bookmark that helps you find and interact with specific parts of your web page.


Next we want to grab the data inputed by user. We can do this by using something called Form Data.
In JavaScript, FormData is a built-in object that allows you to easily construct and manipulate HTML form data before sending it to a server. It provides a way to create a key-value pair representation of form fields and their values, similar to what would be sent in an HTTP POST request.






```javascript

const url = "http://localhost:3000"

const login = (userInfo) => {
  fetch(`${url}/login`, {
    method: "POST",
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json'
    },
    body: JSON.stringify(userInfo)
  })
  .then(response => {
    if (!response.ok) {
      throw response.json()
    }
    localStorage.setItem("token", response.headers.get("Authorization"))
    return response.json()
  })
  .then(data => {
    setCurrUser(data)
  })
  .catch(error => {
    error.then(errorMsg => {
      console.log("error", errorMsg)
    })
  })
}
```

