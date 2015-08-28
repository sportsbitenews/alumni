class BatchDetail extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return(
      <div>
        <div className='batch-detail-header'>
          <div className='batch-detail-name'>
            {this.props.name}
          </div>
          <div className='batch-detail-header-footer'>
            <div className='batch-detail-dates batch-detail-footer-item '>
              {this.props.starts_at} - {this.props.ends_at}
            </div>
            <div className='batch-detail-city batch-detail-footer-item '>
              {this.props.city} CAMP
            </div>
          </div>
        </div>
        <div className='batch-detail-body'>
          <main className='batch-detail-main'>
            {this.props.projects.map(
              (project) => {
                return (
                  <div>
                    {project.name}
                  </div>
                )
              }
            )}
          </main>

          <aside className='batch-detail-side-bar'>
            <div className='batch-members-count section-title'>
              <i className='mdi mdi-account-outline' />
              <div className='section-title-h'>{this.props.students.length} STUDENTS</div>
            </div>
            {_.shuffle(this.props.students).map(student => {
              var participantClasses = classNames({
                'post-detail-participant': true,
                'is-offline': !student.connected_to_slack
              })
              return (
                <a href={Routes.profile_path(student.github_nickname)} className={participantClasses} key={student.id}>
                  <div className='post-detail-participant-avatar'>
                    <img src={student.gravatar_url} className='avatar' />
                  </div>
                  <div className='post-detail-participant-name'>
                    {student.github_nickname}
                  </div>
                  <div className='post-detail-participant-status' />
                </a>
              )
            })}
          </aside>
        </div>
      </div>
    )
  }
}
