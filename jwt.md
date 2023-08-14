

- JWT stands for JSON Web Token, and it is an open standard for securely transmitting information between parties as a JSON object.
- It is commonly used for authentication and authorization in web applications.
- JWTs consist of three parts: the header, the payload, and the signature.

- The header contains metadata about the token and the signing algorithm used.
- The payload carries the claims, which are statements about the user or other data.
- The signature is created by combining the encoded header, encoded payload, and a secret key using a specified algorithm.

- When a user logs in, the server generates a JWT, signs it using a secret key, and sends it back to the client.
- The client stores the token, typically in local storage or a cookie, and includes it in subsequent requests to the server.
- The server can verify the authenticity of the token by validating the signature using the secret key.

JWTs are stateless, scalable, and customizable.  They can be used across different domains or services as they are self-contained.

[Slide 5: Advantages of JWT]
- Stateless: JWTs are stateless, meaning the server does not need to store session information.
- Scalability: Since the server does not keep track of tokens, it can scale horizontally without any shared session storage.
- Cross-Domain: JWTs can be used across different domains or services as they are self-contained.
- Customizable: JWTs can carry custom claims and additional information, making them flexible.

[Slide 6: Implementing JWT with Rails and Devise]
- Devise is a popular authentication solution for Rails applications. We can extend its functionality to use JWT for authentication.
- We need to install the 'devise-jwt' gem, configure it, and make some modifications to the Devise user model.
- When a user logs in, Devise will generate a JWT, sign it, and return it to the client.
- Subsequent requests from the client should include the JWT in the Authorization header for authentication.


### localStorage
localStorage is a feature provided by web browsers that allows applications to store and retrieve data locally on the user's device. It provides a way to store key-value pairs in the form of strings. The data stored in localStorage remains available even after the user closes the browser or navigates away from the website.

Here are the basic methods you can use with localStorage:

localStorage.setItem(key, value): This method is used to store a value in localStorage. The key is a unique identifier for the data, and the value is the actual data you want to store. Both the key and value must be strings.

localStorage.getItem(key): This method retrieves the value associated with a given key from localStorage. It returns null if the key does not exist.

localStorage.removeItem(key): Removes the item associated with the specified key from localStorage.

localStorage.clear(): Removes all items stored in localStorage, effectively clearing the entire storage.

Values stored in localStorage are limited to strings. To store objects or arrays, you need to convert them to strings using methods like JSON.stringify() before storing, and then parse them back to their original format using JSON.parse() when retrieving from localStorage.