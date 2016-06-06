var CityTeachingAssistantList = React.createClass({
  getInitialState() {
    return {
      members: this.props.teaching_assistants,
      role: this.props.role
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
          city={this.props.city}
          memberRole={this.props.role}
          updateMembersList={this.updateMembersList} />
      </div>
    );
  },
  handleRemoveClick(e, member) {
    e.preventDefault();
    axios.railsPatch(
      Routes.city_ordered_lists_path(member.city, { format: 'json' }),
      {
        'github_nickname': member.github_nickname,
        'role': this.props.role,
        'remove': true
      }
    ).then((response) => {
      this.updateMembersList(response.data.members);
    });
  }
});
