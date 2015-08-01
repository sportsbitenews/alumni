class UserActionsClass {
  fetchUser(id) {
    $.get(
      Routes.user_path(id, { format: 'json' }),
      (user) => {
        this.dispatch(user);
      }
    );
  }
}

UserActions = alt.createActions(UserActionsClass);
