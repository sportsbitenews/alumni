class AnswerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  componentDidMount() {
    AnswerStore.listen(this.onStoreChange.bind(this));
    PostStore.listen(this.onPostStoreChange.bind(this));
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this));
    PostStore.unlisten(this.onPostStoreChange.bind(this));
  }

  render() {
    var formClasses = classNames({
      'answer-form': true,
      'is-previewed': this.state.preview,
      'is-editing': this.state.editing,
      'is-blank': this.state.blank,
      'is-sending-post': this.state.pendingPost
    });

    return(
      <div className={formClasses}>
        <div className='answer-form-actions'>
          <a className='answer-form-action answer-form-action-write' onClick={this.onEditClick.bind(this)}>Write</a>
          <hr />
          <a className='answer-form-action answer-form-action-preview' onClick={this.onPreviewClick.bind(this)}>Preview</a>
          <a className="answer-form-action-extra" href="https://guides.github.com/features/mastering-markdown/" target="_blank">
            <span className="octicon octicon-markdown"></span>
            Markdown supported
          </a>
        </div>
        <textarea placeholder="Respond a nice thing" onFocus={this.onFocusInput.bind(this)} ref="content" className='answer-form-input' onKeyUp={this.onKeyUp.bind(this)} onKeyDown={this.onKeyDown.bind(this)} />
        <div className='answer-form-preview' dangerouslySetInnerHTML={{__html: this.state.renderedContent}}></div>
        <div className='answer-form-submit button button-success' onClick={this.postAnswer.bind(this)}>
          Submit your answer
        </div>
      </div>
    )
  }

  onFocusInput(e) {
    e.preventDefault();
    this.setState({
      editing: true
    })
  }

  resetForm() {
    this.setState(this.initialState());
    this.content().value = "";
  }

  goToBottom(e) {
    window.scroll(0, document.body.scrollHeight)
  }

  onStoreChange(store) {
    var newAnswer = store.getNewAnswer();
    this.setState({
      renderedContent: newAnswer.rendered_content
    })
  }

  onPostStoreChange(store) {
    if (this.state.pendingPost){
      this.resetForm();
      this.content().blur();
      this.goToBottom();
    }
  }

  onEditClick(e) {
    e.preventDefault();
    if (this.state.preview) {
      this.setState({
        preview: false,
        renderedContent: this.state.blank ? "Nothing to preview" : "Loading preview"
      })
    }
  }

  onPreviewClick(e) {
    e.preventDefault();
    this.setState({
      preview: true
    })
    if (!this.state.blank) {
      AnswerActions.preview(this.content().value);
    }
  }

  onKeyDown(e) {
    if (e.which == 13 && (e.metaKey || e.ctrlKey)) {
      this.postAnswer()
    }
    else if (e.which == 27 && this.state.blank) {
      this.resetForm();
      this.content().blur();
    }
  }

  postAnswer() {
    AnswerActions.post(this.props.type, this.props.post_id, this.content().value);
    this.setState({
      pendingPost: true
    })
  }

  onKeyUp(e) {
    if (this.content().value == "") {
      this.setState({
        blank: true
      })
    } else if (this.state.blank) {
      this.setState({
        blank: false
      })
    }
  }

  initialState() {
    return {
      editing: false,
      preview: false,
      pendingPost: false,
      renderedContent: "Nothing to preview",
      blank: true
    };
  }

  content() {
    return React.findDOMNode(this.refs.content);
  }
}
