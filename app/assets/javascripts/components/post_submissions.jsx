class PostSubmissions extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      form: this.props.form
    }
  }

  render() {
    var Component = window[this.state.form + "Form"]
    var form = <Component {... this.props} />

    var headerClasses = classNames({
      "post-submissions-header": true,
      "resource-details": this.state.form == "Resource",
      "question-detail": this.state.form == "Question"
    })

    var resourceTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.form == "Resource"
    })

    var questionTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.form == "Question"
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
            <div className={resourceTabClasses} onClick={this.resourceClick.bind(this)}>
              Ressource
            </div>
            <hr/>
            <div className={questionTabClasses} onClick={this.questionClick.bind(this)}>
              Question
            </div>
          </div>
        </div>
      {form}
      </div>
    )
  }

  resourceClick() {
    this.setState({
      form: "Resource"
    })
  }


  questionClick() {
    this.setState({
      form: "Question"
    })
  }

}
