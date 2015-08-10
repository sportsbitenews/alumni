class JobForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      preview: false,
      remote: false,
      renderedContent: "Nothing to preview."
    }
  }

  render() {
    if (this.props.job_errors){
      if (this.props.job_errors.title != undefined) {var errorTitle = this.props.job_errors.title}
      if (this.props.job_errors.content != undefined) {var errorContent = this.props.job_errors.content}
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

    var remoteTrueClass = classNames({
      'is-selected': this.state.remote,
      'remote-selector': true
    })

    var remoteFalseClass = classNames({
      'is-selected': !this.state.remote,
      'remote-selector': true
    })

    var csrfToken = document.querySelector('meta[name=csrf-token]').attributes.content.value;
    var csrfParam = document.querySelector('meta[name=csrf-param]').attributes.content.value;
    var inputCsrf = `<input name=${csrfParam} value=${csrfToken} type='hidden'>`;

    return(
      <form action={Routes.jobs_path()} method='post'>
        <div className='container'>
          <div className='post-submissions-row'>
            <label htmlFor='company' className='hidden-xs'>
              <i className='mdi mdi-star-outline'></i>Company
            </label>
            <input ref='company' defaultValue={this.props.job.company} placeholder="eg. Algolia" name='title' />
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='remote' className='hidden-xs'>
              <i className='mdi mdi-elevator'></i>Remote
            </label>
            <div className='post-submissions-select'>
              <div className={remoteTrueClass} onClick={this.remoteTrue.bind(this)}>
                True
              </div>
              <hr/>
              <div className={remoteFalseClass} onClick={this.remoteFalse.bind(this)}>
                False
              </div>
              <input type='hidden' value={this.state.remote.toString()} />
            </div>

            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='position' className='hidden-xs'>
              <i className='mdi mdi-account-outline'></i>Position
            </label>
            <input ref='position' defaultValue={this.props.job.position} placeholder="eg. Front-end Developer" name='title' />
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='type' className='hidden-xs'>
              <i className='mdi mdi-account-outline'></i>Type
            </label>
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='description' className='hidden-xs'>
              <i className='mdi mdi-message-text-outline'></i>Description
            </label>
            <div className={contentInputClasses}>
              <div className='answer-form-actions question-form-actions'>
                <a className={writeClasses} onClick={this.onWriteClick.bind(this)}>Write</a>
                <hr />
                <a className={previewClasses} onClick={this.onPreviewClick.bind(this)}>Preview</a>
                <a className="question-form-action-extra hidden-xs answer-form-action-extra" href="https://guides.github.com/features/mastering-markdown/" target="_blank">
                  <span className="octicon octicon-markdown"></span>
                  Markdown supported
                </a>
              </div>
              <textarea ref='content' defaultValue={this.props.question.tagline} placeholder='Describe the job' name='description' />
              <div className='question-form-preview' dangerouslySetInnerHTML={{__html: this.state.renderedContent}} />
            </div>
            <div className='errors'>
              {errorContent}
            </div>
          </div>
        </div>
        <div className='post-submissions-submit'>
          <input type='submit' className='button button-question' value='Post it' />
        </div>
        <div dangerouslySetInnerHTML={{__html: inputCsrf}}></div>
      </form>
    )
  }

  remoteFalse() {
    this.setState({ remote: false })
  }

  remoteTrue() {
    this.setState({ remote: true })
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
