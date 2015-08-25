class MilestoneForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      preview: false,
      renderedContent: "Nothing to preview.",
      projectId: this.props.currentUserProjects[0].id
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

    var selectedProject = _.filter(this.props.currentUserProjects, (n) => n.id == this.state.projectId )[0];


    return(
      <form action={Routes.milestones_path()} method='post'>
        <div className='container'>
          <div className='post-submissions-row'>
            <label htmlFor='milestone[project_id]' className='hidden-xs'>
              <i className='mdi mdi-rocket'></i> Product
            </label>
            <div className='post-submissions-select'>
              <ReactBootstrap.DropdownButton ref='selectType' title={selectedProject.name}>
                {this.props.currentUserProjects.map(
                  (project) => <div className="input-selector-item" ref='selector' value={project.id} onClick={this.handleProjectClick.bind(this)}>{project.name}</div>
                )}
              </ReactBootstrap.DropdownButton>
              <input type='hidden' name='milestone[project_id]' value={this.state.projectId} />
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='milestone[title]' className='hidden-xs'>
              <i className='mdi mdi-format-text'></i>Title
            </label>
            <input ref='title' defaultValue={this.props.milestone.title} placeholder="What's news bro ?" name='milestone[title]' />
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='milestone[tagline]' className='hidden-xs'>
              <i className='mdi mdi-message-text-outline'></i>Content
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
              <textarea ref='content' defaultValue={this.props.milestone.content} placeholder='Give us crispy details :)' name='milestone[content]' />
              <div className='question-form-preview' dangerouslySetInnerHTML={{__html: this.state.renderedContent}} />
            </div>
            <div className='errors'>
              {errorContent}
            </div>
          </div>
        </div>
        <div className='post-submissions-submit'>
          <input type='submit' className='button button-milestone' value='Post it' />
        </div>
        <div dangerouslySetInnerHTML={{__html: Csrf.getInput()}}></div>
      </form>
    )
  }

  handleProjectClick(e) {
    this.setState({ projectId: e.target.getAttribute("value") })
    React.findDOMNode(this.refs.selectType).className = "btn-group";
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
