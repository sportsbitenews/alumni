class LanguageDetectionTextarea extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      preview: false,
      frenchSpeaking: false,
      renderedContent: "Nothing to preview",
      blank: true
    }
  }

  componentDidMount() {
    AnswerStore.listen(this.onStoreChange.bind(this));
    PubSub.subscribe('focusRealInput', () => {
      this.content().focus()
      this.content().value = ''
    })
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this));
  }

  render() {
    var componentClasses = classNames({
      'language-detection-textarea': true,
      'has-french-content': this.state.frenchSpeaking,
      'is-previewed': this.state.preview
    })

    var writeValue = this.state.frenchSpeaking ? "Write in 🇬🇧, please 🙏" : 'Write'

    return(
      <div className={componentClasses}>
        <div className='answer-form-actions'>
          <a className='answer-form-action answer-form-action-write' onClick={this.onEditClick.bind(this)}>{writeValue}</a>
          <hr />
          <a className='answer-form-action answer-form-action-preview' onClick={this.onPreviewClick.bind(this)}>Preview</a>
          <a className="answer-form-action-extra" href="https://guides.github.com/features/mastering-markdown/" target="_blank">
            <span className="octicon octicon-markdown"></span>
            Markdown supported
          </a>
        </div>
        <textarea
          placeholder={this.props.placeholder}
          onFocus={this.props.onFocus}
          ref="content"
          defaultValue={this.props.defaultValue}
          name={this.props.name}
          className='answer-form-input answer-form-input-ui'
          onKeyUp={this.onKeyUp.bind(this)}
          onKeyDown={this.props.onKeyDown}
        />
        <div className='answer-form-preview' dangerouslySetInnerHTML={{__html: this.state.renderedContent}}></div>
      </div>
    )
  }

  onPreviewClick(e) {
    e.preventDefault();
    this.setState({ preview: true })
    if (!this.state.blank) {
      AnswerActions.preview(this.content().value);
    }
  }

  onStoreChange(store) {
    var newAnswer = store.getNewAnswer();
    if (newAnswer) {
      this.setState({
        renderedContent: newAnswer.rendered_content
      })
    }
  }

  onKeyUp(e) {
    var content = this.content().value;
    this.isFrenchContent(content)
    if (this.props.setContent) {
      this.props.setContent(content)
    }
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

  onEditClick(e) {
    e.preventDefault();
    if (this.state.preview) {
      this.setState({
        preview: false,
        renderedContent: this.state.blank ? "Nothing to preview" : "Loading preview..."
      })
    }
  }

  resetForm() {
    this.content().value = "";
  }

  isFrenchContent(content) {
    axios.get(`${Routes.language_answers_path()}?content=${content}`)
      .then((response) => {
        if (response.data.french > response.data.english) {
          this.setState({ frenchSpeaking: true })
        } else {
        if (this.state.frenchSpeaking) {
          this.setState({ frenchSpeaking: false })
        }
      }
    })
  }

  content() {
    return React.findDOMNode(this.refs.content);
  }
}
