class StudentItem extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      removed: false
    }
  }

  render() {

    itemClasses = classNames({
      "student-item": true,
      'is-removed': this.state.removed
    })

    return(
      <div>
          <div className={itemClasses}>

            <div className='student-item-actions'>
              <a onClick={this.handleDelete.bind(this)}>
                <i className='mdi mdi-close'></i>
              </a>
            </div>
            <div className="student-item-infos">
              <div className="student-item-name">
                {this.props.student.first_name} {this.props.student.last_name}
              </div>
              <div className="student-item-username">
                @{this.props.student.github_nickname}
              </div>
            </div>
            <div className="student-item-avatar">
              <img src={this.props.student.gravatar_url} />
            </div>
            <div className='student-item-cta' onClick={this.handleValidation.bind(this)}>
              <a>
                <i className='mdi mdi-check'></i>
              </a>
            </div>
          </div>

      </div>
    )
  }

  handleValidation() {
    axios.railsPost(Routes.confirm_user_path(this.props.student.id))
      .then((response) => {this.setState({ removed: true })})
  }

  handleDelete() {
    if (confirm("Are you sure") === true) {
      axios.railsPost(Routes.delete_user_path(this.props.student.id))
        .then((response) => {this.setState({ removed: true })
      })
    }
  }

}
