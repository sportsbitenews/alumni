class AnswerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  componentDidMount() {
    PostStore.listen(this.onPostStoreChange.bind(this));
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onPostStoreChange.bind(this));
  }

  render() {
    var formClasses = classNames({
      'answer-form': true,
      'is-editing': this.state.editing,
      'is-blank': this.state.blank,
      'is-sending-post': this.state.pendingPost
    });

    var fakeTextAreaClasses = classNames({
      'answer-form-input': true,
      'hidden': this.state.editing
    })

    var mentionComponent;

    if(this.state.isEditing) {
      mentionComponent = <GhNicknameMention {...this.props} />
    }

    return(
      <div className={formClasses}>
        <LanguageDetectionTextarea
          placeholder=   {"Say something nice, in english please."}
          onFocus=       {this.onFocusInput.bind(this)}
          onKeyDown=     {this.onKeyDown.bind(this)}
          setContent=    {this.setContent.bind(this)}
        />
        <textarea
          className=   {fakeTextAreaClasses}
          onFocus=     {this.onFocusInput.bind(this)}
          placeholder= 'Say something nice!'
        />
        <div className='answer-form-actions-submit'>
          <div className='answer-form-submit button button-discret' onClick={this.closeForm.bind(this)}>
            Cancel
          </div>
          <div className='answer-form-submit button button-success' onClick={this.postAnswer.bind(this)}>
            Submit your answer
          </div>
        </div>
      </div>
    )
  }

  onFocusInput(e) {
    e.preventDefault();
    if (!this.state.editing){
      this.setState({
        editing: true
      })
      PubSub.publish('focusRealInput')
    }
  }

  closeForm() {
    this.setState(this.initialState());
  }

  goToBottom(e) {
    window.scroll(0, document.body.scrollHeight)
  }

  onPostStoreChange(store) {
    if (this.state.pendingPost){
      this.setState({
        editing: false,
        pendingPost: false
      })
    }
  }

  onKeyDown(e) {
    if (e.which === 13 && (e.metaKey || e.ctrlKey)) {
      this.postAnswer()
    }
    else if (e.which === 27) {
      this.closeForm();
    }
  }

  setContent(content) {
    this.setState({ content: content })
  }

  postAnswer() {
    AnswerActions.post(this.props.type, this.props.post_id, this.state.content);
    this.setState({ pendingPost: true })
  }

  initialState() {
    return {
      pendingPost: false,
      editing: false,
      content: ''
    };
  }
}
