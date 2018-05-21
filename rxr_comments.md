# Rahul's Comments

Your application does what it should. Good job!

So, design. I'm still struggling with this too, but my approach would be very clear about how the outside world (the operator of the program and other objects) interacts with the object that I created. A good strategy to reducing the cost of change (ie. modular code) is to focus on behavior rather than exact implementation. It shouldn't matter _how_ an object does something, as long as it responds to the message I send it in the way it should.

In the case of our application, this might mean the following: Focus your tests less on whether there is an array inside the airport class and don't rely on it in your tests because it ties down the code even though it's just a specific possibility to implement the responsibility of "holding planes". You did an excellent job when testing "fullness" of the airport: Instead of checking @planes.count == @capacity, you tested the _behavior_! 