var Mood = React.createClass({
  getInitialState: function() {
    return {
      content: this.props.mood,
      isEditable: this.props.current_user.github_nickname == this.props.github_nickname,
      isMoodHidden: false
    };
  },

  render: function() {
    var userMoodClasses = classNames({
      'hidden': this.state.isMoodHidden
    })
    var userMoodFormClasses = classNames({
      'hidden': !this.state.isMoodHidden
    })
    var userMoodPenClasses = classNames({
      'is-editable': this.state.isEditable,
      'mdi mdi-pencil': true,
      'hidden': !this.state.isEditable
    })

    var mood = null;
    if (this.state.content) {
      var mood = (<p>{this.state.content} <i className={userMoodPenClasses}></i></p>);
    } else if (this.props.current_user.github_nickname == this.props.github_nickname) {
      var mood = (<p>What you look for/ what you bring ... <i className={userMoodPenClasses}></i></p>);
    } else {
      var mood = (<p></p>);
    }

    return (
      <div>
        <div className={userMoodClasses} onClick={this.handleClick}>
          {mood}
        </div>
        <div className={userMoodFormClasses}>
          <input ref="mood" type="text" onKeyDown={this.handleKeydown} placeholder="What you look for/ what you bring ..." className="form-control" />
        </div>
      </div>
    );
  },

  handleClick() {
    this.setState({isMoodHidden: true});
  },

  handleKeydown(e) {
    if (e.which == 13 && this.state.isMoodHidden) {
      var moodValue = React.findDOMNode(this.refs.mood).value;
      axios.railsPatch(Routes.edit_profile_path(this.props.current_user.id, { format: 'json' }), {"mood": moodValue})
        .then((response) => {
          this.setState({
            content: response.data.mood,
            isEditable: response.data.current_user.github_nickname == response.data.github_nickname,
            isMoodHidden: false
          })
        })
    }
  }
});
