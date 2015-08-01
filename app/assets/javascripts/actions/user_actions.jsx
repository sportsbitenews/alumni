class UserActionsClass {
  fetchUsers(ids) {
    $.get(
      Routes.users_path({ ids: ids, format: 'json' }),
      (data) => this.dispatch(data.users)
    );
  }
}

UserActions = alt.createActions(UserActionsClass);
