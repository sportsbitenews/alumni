class QuestionForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      preview: false,
      renderedContent: "Nothing to preview."
    }
  }

  render() {
    if (this.props.errors){
      if (this.props.errors.title != undefined) {var errorTitle = this.props.errors.title}
      if (this.props.errors.content != undefined) {var errorContent = this.props.errors.content}
    }
    var writeClasses = classNames({
      'answer-form-action': true,
      'is-active': !this.state.preview
    })
    var previewClasses = classNames({
      'answer-form-action': true,
      'is-active': this.state.preview
    })

    var contentInputClasses = classNames({
      'question-form-input': true,
      'is-previewed': this.state.preview
    })

    return(
      <form action={Routes.questions_path()} method='post'>
        <div className='container'>
          <div className='post-submissions-row'>
            <label htmlFor='question[title]' className='hidden-xs'>
              <i className='mdi mdi-format-text'></i>Title
            </label>
            <input ref='title' defaultValue={this.props.question.title} placeholder="What's your question ? Be specific" name='question[title]' />
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='question[tagline]' className='hidden-xs'>
              <i className='mdi mdi-message-text-outline'></i>Content
            </label>
            <LanguageDetectionTextarea
              defaultValue={this.props.question.content}
              placeholder='Describe your problem, in english please. Also, use Markdown.'
              name='question[content]'
            />

            <div className='errors'>
              {errorContent}
            </div>
          </div>
        </div>
        <div className='post-submissions-submit'>
          <input type='submit' className='button button-question' value='Post it' />
        </div>
        <div dangerouslySetInnerHTML={{__html: Csrf.getInput()}}></div>
      </form>
    )
  }

  componentDidMount() {
    AnswerStore.listen(this.onStoreChange.bind(this));
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this));
  }

  onStoreChange(store) {
    if (this.state.preview) {
      this.setState({
        renderedContent: store.new_answer.rendered_content == "" ? "Nothing to preview." : store.new_answer.rendered_content
      })
    }
  }

  onWriteClick(e) {
    e.preventDefault();
    this.setState({
      preview: false
    })
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

  content() {
    return React.findDOMNode(this.refs.content);
  }
}
