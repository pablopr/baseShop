<h2><%= t("registration")%></h2>
<div class="inner">
  <div id="registration_error"></div>
    <div id="registration_choice">         
        <h3><%= t("register_or_guest") %></h3>   
	    <p>
	          <input id="choose_register" type="radio" name="choose_registration" value="register" />
		        <label for="choose_register"><%= t("register") %></label>
			    </p>         
			        <p>
				      <input id="choose_existing" type="radio" name="choose_registration" value="existing"/>
				            <label for="choose_existing"><%= t("existing_customer") %></label>
					        </p>         
						          
							    </div>
							      <div id="registration_input">
							          <div id="existing_user">
								        <h3><%= t("already_registered") %></h3>
									      <div id="login">
									              <p>
										                <%= label :user_session, :login, t("email") %>
												          <%= text_field :user_session, 'login', :class => 'required' %><span class="req">*</span>
													          </p>
														          <p>
															            <%= label :user_session, :password, t("password") %>
																              <%= password_field :user_session, 'password', :class => 'required' %><span class="req">*</span>
																	              </p>
																		            </div>
																			        </div>
																				    <div id="new_user">
																				          <h3><%= t("create_user_account") %></h3>
																					          <p>                                              
																						          <label for="<%= t("email") %>"><%= t("email") %></label>
																							              <%= text_field :user, 'email', :class => 'required' -%><span class="req">*</span>
																								                </p>
																										          <p>
																											              <label for="<%= t("password") %>"><%= t("password") %></label>
																												                  <%= password_field :user, 'password', :class => 'required' %><span class="req">*</span>
																														            </p>
																															              <p>
																																                  <label for="<%= t("confirm") %>"><%= t("confirm") %></label>
																																		              <%= password_field :user, 'password_confirmation', :class => 'required' %><span class="req">*</span>
																																			                </p>
																																					      </div>
																																					          </div>
																																						    <div id="already_logged_in"><p>You are already logged in.</p></div>
																																						      <div class="form-buttons">
																																						          <input id="continue_registration" type="button" class="button primary" value="<%=t("continue") %>"/>
																																							    </div>
																																							    </div>
