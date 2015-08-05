class PostSubmissions extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      form: "Resource"
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
    return(
      <div>
        <div className={headerClasses}>
          <div className='container'>
            Post a {this.state.form.toLowerCase()}
          </div>
        </div>
        <div className='post-submissions-tabs-overlay'>
          <div className='post-submissions-tabs'>
            <div className='post-submissions-tab' onClick={this.resourceClick.bind(this)}>
              Ressource
            </div>
            <hr/>
            <div className='post-submissions-tab' onClick={this.questionClick.bind(this)}>
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
