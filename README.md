# Airport_challenge

```
        ______
        _\____\___
=  = ==(____MA____)
          \_____\___________________,-~~~~~~~`-.._
          /     o o o o o o o o o o o o o o o o  |\_
          `~-.__       __..----..__                  )
                `---~~\___________/------------`````
                =  ===(_________)

```

This project is our first weekend challenge (completed solo on 19-20th May 2018). We were given user stories and instructed to write the software to control the flow of planes at an airport.

## Motivation 

This project has been created to help airports (mainly airport traffic controllers) control the flow of planes. It has been designed with the idea that it can be used across multiple airports in mind, so has some default settings (e.g. capacity) that can be overridden. 

<!-- Really good intro and motivation. It gives a clear idea what this is about. -->

## Getting started

1. Fork this repo, and clone to your local machine
2. Run the command `gem install bundle` (if you don't have bundle already)
3. When the installation completes, run `bundle`

## Usage

<!-- I think it might be better to copy-paste what you did in the terminal right into markdown. To write code snippets in markdown (terminal stuff also counts as code) you do it like this:

```
code goes in here
``` -->


Navigate to the root folder in this project directory on the command line to begin. 

Use the following commands on the command line: 

**Airport.initialize(capacity)** -> to change the capacity of the aiport (airport is set with a default capacity of 30)<br />
**Airport.land(plane)** -> to instruct a plane to land at an airport<br />
**Airport.full?** -> to check if the airport is full<br />
**Airport.take_off(plane)** -> to instruct a plane to take off from an airport. The plane argument is optional, if none is entered it will return the next available plane<br /> 
**Airport.check_plane(plane)** -> to confirm that the plane is no longer in the airport<br />
<!-- I don't think check_plane is a good name. Check what about the plane? Whoever inherits your code might be led to think this method tells you about whether the aircraft is working, rather than telling you whether it is at the airport. -->
**Airport.runway_closed?** -> to check if the airport is able to takeoff/land planes<br />
<!-- * naming: Well, it's not that planes can't land because the runway is closed. Maybe we will indeed need to create a method later that is specially for designating which runway a plane may land/take-off from. Something like take_off_authorization with might be better.
* update your readme: I can't find this method in your airplane.rb. Is your readme up-to-date? -->
**Airport.planes** -> to show all the current planes in the hangar<br />
<!-- I think this is fine. If we had more context, it would be easier to decide whether or not planes should be accessible from outside the class. -->
**Airport.stormy?** -> will return true if the weather is stormy (note that planes can't land or take off in stormy conditions)
<!-- Why is it the airport's responsibility to decide whether it's stormy? Doesn't it make sense for the airport to get weather information from, say, a Weather_Station class? -->

**Plane.flying?** -> will return true if the plane is flying, or false if it's grounded 

## Tech/Framework used 

Built in Ruby (version 2.5.0)<br />
Tested using Rspec (version 3.7) 

<!-- I would only do one empty line between two lines of code/text. -->

## Running tests

run `rspec` from the projects <!-- project's --> root directory. 

## Credits 

With thanks to the following resources that have helped me on this project

* Akash Nimare for his blog on README's - https://medium.com/@meakaakka/a-beginners-guide-to-writing-a-kickass-readme-7ac01da88ab3

<!-- That's a cute acknowledgement. I think it's a really nice thing to do - mention the people who've helped you. -->

## Skills I used creating thing project 

TDD
* Writing all tests before code 
* Unit testing classes in isolation (using doubles)
* Use Rspec matchers 
* Write guard conditions 
* Use constants
* Extract domain models from user stories, and turn them into feature tests.

