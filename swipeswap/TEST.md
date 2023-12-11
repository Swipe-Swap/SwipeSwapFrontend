# Testing
GENERAL OVERVIEW
- Soham is handling rendering, so that does not need to be tested
- Anything that takes input gets tested to ensure proper validation
- Any logic gets unit tested

> These test cases are subject to change if we determine that there's a better structure moving forward
* Note for the provider methods only one render test is necessary; a "base case" if you will

## PLANNING
Potential avenues
1. 
   - Rewrite code base
   - Come up with a list of test cases
2. 
   - Integration tests
   - Test logic 'ad-hoc'
3.
   - Implement ALL of the logic, no GUI, straight-up logic flow, and thoroughly test all of it
   - Then, start writing/adapting integration tests using the GUI
I think we're going to go with avenue 3
## TODO
- Implement ALL of the logic, no GUI, straight-up logic flow, and thoroughly test all of it
- Then, start writing/adapting integration tests using the GUI

### REWRITING
- We're rewriting the codebase to isolate widgets and their logic into separate functions, that way we can test the logic standalone and better understand what logic is going on in our codebase
### TESTS
- [] order_model.dart
  - [] toJson()
  - [] fromJson()
- [] seller_model.dart
  - [] toJson()
  - [] fromJson()
- [] user_model.dart
  - [] toJson()
  - [] fromJson()
- [] order_provider.dart 
  - setDiningCourt()
  - setBuyer()
  - setSeller()
- [] screen_provider.dart
  - setTab()
- [] seller_provider.dart
  - setDiningCourt()
  - setSeller()
- [] user_provider.dart
  - setUser()
- [] 
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []
- []