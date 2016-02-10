GhNicknameMention = React.createClass({

  mixins: [MentionsMixin],

  getInitialState: function() {
    return {
      value: this.props.original_content
    };
  },

  render: function() {
    var actionButtons;
    if(this.props.edit) {
      actionButtons = <div className='button button-success' onClick={this.updateAnswer}>
                        Edit your answer
                      </div>
    } else {
      actionButtons =   <div className='answer-form-actions-submit'>
                          <div className='answer-form-submit button button-discret' onClick={this.handleCancel}>
                            Cancel
                          </div>
                          <div className='answer-form-submit button button-success' onClick={this.handleSubmit}>
                            Submit your answer
                          </div>
                        </div>
    }
    var divClasses = classNames({
      'answer-edit': this.props.edit
    })
    var textareaClasses = classNames({
      'answer-form-input': !this.props.edit,
      'answer-form-input-ui': !this.props.edit,
      'answer-form-edit': this.props.edit
    })
    return (
      <div className={divClasses}>
        <ReactMentions.MentionsInput
          value={this.state.value}
          onChange={this.handleChange}
          placeholder={this.props.placeholder}
          displayTransform={this.displayTransform}
          className={textareaClasses}
          ref='mentionInput'
          onKeyUp={this.props.onKeyUp}>

          <ReactMentions.Mention
            type="user"
            trigger="@"
            data={ this.onNewUserCharacter }
            renderSuggestion={this.renderSuggestion}
            onAdd={this.handleAdd}
            onRemove={this.handleRemove} />
        </ReactMentions.MentionsInput>
        {actionButtons}
      </div>
    );
  },

  onNewUserCharacter: function(query, callback) {
    UserActions.getUsers(query, callback);
  },

  handleCancel: function() {
    this.props.onCancelClick()
  },

  handleSubmit: function() {
    this.props.onSubmitClick(React.findDOMNode(this.refs.mentionInput.getTextareaRef()).value)
  },

  // handleKeyUp: function() {
  //   this.props.onKeyUp(React.findDOMNode(this.refs.mentionInput.getTextareaRef()).value)
  // },

  // handleKeyDown: function(e) {
  //   this.props.onKeyDown(e)
  // },

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
  },

  getContent: function() {
    return this.refs.mentionInput.getTextareaRef();
  }

});