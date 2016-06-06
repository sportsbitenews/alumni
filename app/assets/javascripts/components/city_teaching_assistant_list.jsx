var CityTeachingAssistantList = React.createClass({
  getInitialState() {
    return {
      members: this.props.teaching_assistants
    };
  },
  updateMembersList: function(members) {
    this.setState({members: members});
  },
  render: function() {
    return (
      <div>
        {this.state.members.map((member, index) => {
          return (
            <div className="manager-box" key={index}>
              <div className="manager-avatar">
                <img className="avatar" src={member.gravatar_url} alt="" />
              </div>
              <div className="manager-username">
                {member.github_nickname}
              </div>
              <button className='manager-button manager-button-kill'
                  onClick={(e) => { this.handleRemoveClick(e, member) }} >
                <i className="mdi mdi-window-close" />
              </button>
            </div>
          )
        })}
        <TeamMemberForm
          city={this.props.city_slug}
          url={Routes.set_member_city_path(this.props.city, { format: 'json' })}
          memberRole='teaching_assistant'
          updateManagers={this.updateMembersList} />
      </div>
    );
  },
  handleRemoveClick(e, manager) {
    e.preventDefault();
    axios.railsPost(
      Routes.set_manager_city_path(manager.city, { format: 'json' }),
      {
        'github_nickname': manager.github_nickname,
        'remove': true
      }
    ).then((response) => {
      this.updateManagersList(response.data.managers);
    });
  }
});
