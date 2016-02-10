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
          onCancelClick= {this.closeForm.bind(this)}
          onSubmitClick= {this.postAnswer.bind(this)}
        />
        <textarea
          className=   {fakeTextAreaClasses}
          onFocus=     {this.onFocusInput.bind(this)}
          placeholder= 'Say something nice!'
        />
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
    else if (e.which === 27 && this.state.blank) {
      this.resetForm();
      this.content().blur();
    }
  }

  setContent(content) {
    this.setState({ content: content })
  }

  postAnswer(content) {
    AnswerActions.post(this.props.type, this.props.post_id, content);
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
