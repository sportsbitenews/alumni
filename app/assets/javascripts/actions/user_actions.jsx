class UserActionsClass {
  fetchUsers(ids) {
    if (ids.length > 0) {
      axios.get(Routes.users_path({ ids: ids, format: 'json' }))
        .then((response) => this.dispatch(response.data));
    }
  }
}

UserActions = alt.createActions(UserActionsClass);
