
###Using the library in your project
Add the library project to your workspace or project.
Add the library scheme (NSPredicateDictionary) to the Build portion of your scheme.
Make the library product (libNSPredicateDictionary.a) a dependancy of your target.
Link against the library.

Import the header in the classes that use it:

#import <NSPredicateDictionary/NSPredicateDictionary.h>

Make sure your project has the "Other Linker Flag" "-all_load" set.
See [Technical Q&A QA1490](https://developer.apple.com/library/ios/qa/qa1490/_index.html) for an explanation of why.


###Customizing behavior
