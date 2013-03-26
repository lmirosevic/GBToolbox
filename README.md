GBToolbox
============

Goonbee's iOS & Mac development toolbox

Documentation
------------

### Common Macros ###

## Logging ##

- **l(...)**: Shorthand for NSLog(...)

## Localisation ##

- **_s(string, description)**: Shorthand for NSLocalizedString(...)

## Lazy instantiation ##

- **_lazy(Class, propertyName, ivar)**: Shorthand for creating a getter which lazily instantiates the ivar if it is `nil` at access using `[[Class alloc] init]`

## Associated object ##

- **_associatedObject(storage, atomicity, type, getter, setter)**: Shorthand for creating an associated object (for properties in categories) including storage, getter and setter.

## Sets ##

- **_set(...)**: Shorthand for creating an NSSet: `[NSSet setWithArray:@[...]]`

## Resource Bundles ##

- **_res(bundle, resource)**: Shorthand for creating path for bundle resource.

## Singleton ##

- **_singleton(Class, accessor)**: Shorthand for creating a singleton getter.

## Debugging ##

- **_b(expression)**: Returns `@"YES"` or `@"NO"` if the expression is evaluates to true or false respectively.

- **_lRect(rect)**: Logs an NSRect or CGRect

- **_lPoint(point)**: Logs a CGPoint

- **_lSize(size)**: Logs an NSSize or CGSize

- **_lObject(object)**: Logs an object by sending it the `description` message

- **_lString(string)**: Logs a string

- **_lFloating(floating)**: Logs a floating point number

- **_lIntegral(integral)**: Logs an integral number

- **_lBoolean(boolean)**: Logs a boolean

## Strings ##

- **IsEmptyString(string)**: Evaluates to true if the string is not nil, is kind of class `NSString` and isnt the empty string `@""`

- **IsValidString(string)**: Opposite of `IsEmptyString`

- **_f(string, ...)**: Shorthand for `[NSString stringWithFormat:string, ...]`

## Code introspection ##

- **IsClassAvailable(classType)**: Returns true if class is available at runtime. Useful for checking if certain features are available.


Dependencies
------------

iOS System Frameworks (link them in superproject):

* CoreGraphics
* QuartzCore

OS X System Frameworks (link them in superproject):

* CoreGraphics
* QuartzCore

Copyright & License
------------

Copyright 2013 Luka Mirosevic

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.