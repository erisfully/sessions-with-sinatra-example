# Sessions with Sinatra

This app shows a sample usage of sessions with Sinatra. It:

- allows a user to sign in
- allows a user to sign out

Key points:

- sessions have been enabled for this Sinatra app

        class SessionApp < Sinatra::Base
          enable :sessions
          ...

- only the ID of the signed in user is stored in the session, not the entire user
- this is a simple authentication example used to illustrate sessions, not how to properly write user authentication

## Sessions

Sessions are used to keep track of a user's information while they
user your web application. Without sessions, every time a new HTTP
request came in to our Sinatra application, the app wouldn't remember
which user was signed in and requesting a page.

Sessions are actually based on HTTP cookies. Cookies are sent back and forth
in HTTP requests and responses as headers. Because we don't want to
deal with the HTTP headers directly, Sinatra gives us access to the
session information through the `session` object.

Sessions are often used to keep track of what user is signed in.
Since a user can see their HTTP cookies in the browser, if they
delete their session cookie then they will no longer be logged in
to your site.

## The session object

The `session` object acts just like a hash.

You can add data to it:

        session[:user_id] = 1

Something like this would be helpful to when a user is signing in.

You can remove data from it:

        session.delete(:user_id)

Something like this would be helpful when a user is signing out.

Data that you put into the session in one action is available to other
actions that come after it:

        get "/" do
          session[:visited_homepage] = true
          erb :home, locals: {user: user}
        end

        get "/about" do
          if session[:visited_homepage] == true
            show_banner = false
          else
            show_banner = true
          end
          erb :home, locals: {show_banner: show_banner}
        end

In this example, if a user goes directly to the about page, they will
see the banner since `session[:visited_homepage]` will be `false`.
However, if they visit the homepage first, then the about page, they
will not see the banner since `session[:visited_homepage]` will be `true`.
