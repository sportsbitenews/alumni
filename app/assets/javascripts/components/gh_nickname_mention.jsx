GhNicknameMention = React.createClass({

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
          markup="@[__display__](__type__:__id__)"
          placeholder={"Mention people using '@'"}
          className="answer-form-edit">

          <ReactMentions.Mention
            type="user"
            trigger="@"
            data={ this.props.data }
            renderSuggestion={this.renderSuggestion}
            onAdd={this.handleAdd}
            onRemove={this.handleRemove} />
        </ReactMentions.MentionsInput>
        <div className='button button-success' onClick={this.updateAnswer.bind(this)}>
          Edit your answer
        </div>
      </div>
    );
  },

  updateAnswer: function() {
    if (this.props.type == 'FirstItem') {
      PostActions.update(React.findDOMNode(this.refs.editForm).value, this.props.post_type, this.props.id)
    } else {
      AnswerActions.update(this.props.id, React.findDOMNode(this.refs.editForm).value)
    }
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

  handleChange: function(ev, value) {
    this.setState({
      value: value
    })
  }

});