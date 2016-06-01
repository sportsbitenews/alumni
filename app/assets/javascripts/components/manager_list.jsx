var ManagerList = React.createClass({
  getInitialState() {
    return {
      managers: this.props.managers
    };
  },
  updateManagersList: function(result) {
    this.setState({managers: result});
  },
  render: function() {
    return (
      <div>
        {this.state.managers.map(function(manager, index) {
          return (
            <div className="manager-box">
              <div className="manager-avatar">
                <img className="avatar" src={manager.gravatar_url} alt="" />
              </div>
              <div className="manager-username">
                @{manager.github_nickname}
              </div>
              <ManagerKillButton
                github_nickname={manager.github_nickname}
                city={manager.city}
                updateManagers={this.updateManagersList} />
            </div>
          )
        })}
        <ManagerForm city={this.props.city_slug} updateManagers={this.updateManagersList} />
      </div>
    );
  }
});
