class PostSubmissions extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      form: this.props.form
    }
  }

  render() {
    var headerClasses = classNames({
      "post-submissions-header": true,
      "resource-details": this.state.form == "Resource",
      "question-detail": this.state.form == "Question",
      "job-detail": this.state.form == "Job"
    })

    var resourceTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.form == "Resource"
    })

    var questionTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.form == "Question"
    })

    var jobTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.form == "Job"
    })

    return(
      <div>
        <div className={headerClasses}>
          <div className='container'>
            Post a <span>{this.state.form.toLowerCase()}</span>
          </div>
        </div>
        <div className='post-submissions-tabs-overlay'>
          <div className='post-submissions-tabs'>
            <div className={resourceTabClasses} onClick={this.onResourceTabClick.bind(this)}>
              Ressource
            </div>
            <hr/>
            <div className={questionTabClasses} onClick={this.onQuestionTabClick.bind(this)}>
              Question
            </div>
            <hr />
            <div className={jobTabClasses} onClick={this.onJobTabClick.bind(this)}>
              Job
            </div>
          </div>
        </div>
        <div className='post-submissions-body'>
          <div className={resourceTabClasses}>
            <ResourceForm {...this.props} />
          </div>
          <div className={questionTabClasses}>
            <QuestionForm {...this.props} />
          </div>
          <div className={jobTabClasses}>
            <JobForm {...this.props} />
          </div>
        </div>
      </div>
    )
  }

  onResourceTabClick() {
    this.displayForm('Resource')
  }

  onQuestionTabClick() {
    this.displayForm('Question')
  }

  onJobTabClick() {
    this.displayForm('Job')
  }

  displayForm(type) {
    this.setState({ form: type });
    path = `new_${type.toLowerCase()}_path`;
    console.log(path)
    history.replaceState('/', '/', Routes[path]({}));
  }

}
