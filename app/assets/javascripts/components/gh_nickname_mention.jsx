GhNicknameMention = React.createClass({

  mixins: [MentionsMixin],

  getInitialState: function() {
    return {
      value: this.props.original_content
    };
  },

  render: function() {
    return (
      <div className='answer-edit'>
        <ReactMentions.MentionsInput
          value={this.state.value}
          onChange={this.handleChange}
          placeholder={"Mention people using '@'"}
          displayTransform={this.displayTransform}
          className="answer-form-edit"
          ref='mentionInput'>

          <ReactMentions.Mention
            type="user"
            trigger="@"
            data={ this.onNewUserCharacter }
            renderSuggestion={this.renderSuggestion}
            onAdd={this.handleAdd}
            onRemove={this.handleRemove} />
        </ReactMentions.MentionsInput>
        <div className='button button-success' onClick={this.updateAnswer}>
          Edit your answer
        </div>
      </div>
    );
  },

  onNewUserCharacter: function(query, callback) {
    UserActions.getUsers(query, callback);
  },

  updateAnswer: function() {
    var value = React.findDOMNode(this.refs.mentionInput.getTextareaRef()).value;
    if (this.props.type == 'FirstItem') {
      PostActions.update(value, this.props.post_type, this.props.id)
    } else {
      AnswerActions.update(this.props.id, value)
    }
  },

  displayTransform: function(id, display) {
    return '@' + id;
  },

  handleRemove: function() {
    console.log("removed a mention", arguments);
  },

  handleAdd: function() {
    console.log("added a new mention", arguments);
  },

  renderSuggestion: function(id, display, search, highlightedDisplay) {
    return (
      <div className="user">
        { highlightedDisplay }
      </div>
    );
  }

});