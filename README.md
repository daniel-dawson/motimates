# README

<% if user_signed_in? %>
Signed in as
<%= current_user.email %>. Not you?
<%= link_to "Edit profile", edit_user_registration_path %>
<%= link_to "Sign out", destroy_user_session_path, :method => :delete %>
<% else %>
<%= link_to "Sign up", new_user_registration_path %>
or
<%= link_to "sign in", new_user_session_path %>
<% end %>

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
