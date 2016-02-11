class UserActionsClass {
  getUsers(query, callback) {
    axios.railsGet(Routes.users_path({ query: query, format: 'json' }))
      .then((response) => callback(response.data))
  }
}

UserActions = alt.createActions(UserActionsClass);
