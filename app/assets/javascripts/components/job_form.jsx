class JobForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      preview: false,
      remote: false,
      renderedContent: "Nothing to preview.",
      type: 'Freelance'
    }
  }

  render() {
    if (this.props.job_errors){
      if (this.props.job_errors.company != undefined) {var errorCompany = this.props.job_errors.company}
      if (this.props.job_errors.description != undefined) {var errorDescription = this.props.job_errors.description}
      if (this.props.job_errors.title != undefined) {var errorTitle = this.props.job_errors.title}
      if (this.props.job_errors.city != undefined) {var errorCity = this.props.job_errors.city}
      if (this.props.job_errors.ad_url != undefined) {var errorAdUrl = this.props.job_errors.ad_url}
      if (this.props.job_errors.contact_email != undefined) {var errorContactEmail = this.props.job_errors.contact_email}
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

    var inputCityClasses = classNames ({
      'post-submissions-row': true,
      'hidden': this.state.remote
    })

    var selectTypeClasses = classNames({
      "is-closed": this.state.selectTypeClosed
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
            <input ref='company' defaultValue={this.props.job.company} placeholder="eg. Algolia" name='company' />
            <div className='errors'>
              {errorCompany}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='title' className='hidden-xs'>
              <i className='mdi mdi-account-outline'></i>Title
            </label>
            <input ref='title' defaultValue={this.props.job.title} placeholder="eg. Front-end Developer" name='title' />
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
              <input type='hidden' name='remote' value={this.state.remote.toString()} />
            </div>
          </div>
          <div className={inputCityClasses}>
            <label htmlFor='city' className='hidden-xs'>
              <i className='mdi mdi-city'></i>City
            </label>
            <input ref='city' defaultValue={this.props.job.city} placeholder="eg. San Francisco" name='city' />
            <div className='errors'>
              {errorCity}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='contract' className='hidden-xs'>
              <i className='mdi mdi-content-paste'></i>Type
            </label>
            <div className='post-submissions-select'>
              <ReactBootstrap.DropdownButton ref='selectType' className={selectTypeClasses} title={this.state.type}>
                  <div className="input-selector-item" ref='selector' onClick={this.handleTypeClick.bind(this)}>Freelance</div>
                  <div className="input-selector-item" ref='selector' onClick={this.handleTypeClick.bind(this)}>Employee</div>
                  <div className="input-selector-item" ref='selector' onClick={this.handleTypeClick.bind(this)}>Internship</div>
              </ReactBootstrap.DropdownButton>
              <input type='hidden' name='contract' value={this.state.type} />
            </div>
          </div>
          <div className="post-submissions-row">
            <label htmlFor='link' className='hidden-xs'>
              <i className='mdi mdi-link-variant'></i>Link
            </label>
            <input ref='adUrl' defaultValue={this.props.job.ad_url} placeholder="http://wwww..." name='ad_url' />
            <div className='errors'>
              {errorAdUrl}
            </div>
          </div>
          <div className="post-submissions-row">
            <label htmlFor='contact_email' className='hidden-xs'>
              <i className='mdi mdi-email-outline'></i>Contact
            </label>
            <input ref='contactEmail' defaultValue={this.props.job.contact_email} placeholder="tchret@gmail.com" name='contact_email' />
            <div className='errors'>
              {errorContactEmail}
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
              {errorDescription}
            </div>
          </div>
        </div>
        <div className='post-submissions-submit'>
          <input type='submit' className='button button-job' value='Post it' />
        </div>
        <div dangerouslySetInnerHTML={{__html: inputCsrf}}></div>
      </form>
    )
  }

  handleTypeClick(e) {
    this.setState({ type: e.target.innerHTML })
    React.findDOMNode(this.refs.selectType).className = "btn-group";
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
