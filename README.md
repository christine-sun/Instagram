# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **16** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [ ] Allow the logged in user to add a profile photo
  - [ ] Display the profile photo with each post
  - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] User can like a post and see number of likes for each post in the post details screen.
- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [x] User can choose between camera and photo album in compose mode
- [x] User can see multiple tabs along Tar Bar that represent tabs in real Instagram
- [x] Create a tab for the camera view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How can we best promote reusability between table view and collection view cells?
2. How can the edited image crop be edited so it is not limited to a 1:1 aspect ratio?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Splash screen, app icon, sign up
![](https://i.imgur.com/8Tfj8YR.gif)

Login, view feed, refresh
![](https://media.giphy.com/media/6BtR5haBG20D4qMVa8/giphy.gif)

Create a new post
![](https://media.giphy.com/media/WrqtzMORUYGycD4QAi/giphy.gif)

User persistence
![](https://i.imgur.com/PCsIJdL.gif)

Scroll, profile, log out
![](https://i.imgur.com/Xkkrf5i.gif)

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [Parse] back-end
- Splash screen https://twitter.com/wongmjane/status/1204103134173220864
- Guide https://courses.codepath.org/courses/ios_university_fast_track/unit/9#!assignment


## Notes

Describe any challenges encountered while building the app.

Cells collapsing in table view for home feed was resolved with a placeholder image.
Proper "show" navigation style fixed by maintaining only one main navigation controller in the storyboard.

## License

    Copyright 2021 Christine Sun

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
