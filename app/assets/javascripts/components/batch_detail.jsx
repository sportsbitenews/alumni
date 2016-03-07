class BatchDetail extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      sidebarHeight: "100%"
    }
  }

  render() {
    var sidebarStyle = {
      height: this.state.sidebarHeight
    }

    var sideBarClasses = classNames({
      'batch-detail-side-bar': true,
      'is-collapsed': this.state.sidebarHeight != "100%"
    })

    var coverStyle
    if (this.props.cover_image) {
      coverStyle = {
        backgroundImage: 'url(' + this.props.cover_image + ')'
      }
    }

    if (this.props.youtube_id) {
      var live = null;
      if (this.props.live) {
        live = <div className='section-title-h ranked-by-milestone live'><span className='round' />LIVE</div>;
      }
      var demoDay = (
        <div>
          <div className='batch-members-count section-title'>
            <i className='mdi mdi-star-outline' />
            <div className='section-title-h'>DEMO DAY</div>
            {live}
          </div>
          <div className='iframe-container'>
            <div className='video-container'>
              <iframe src={`https://www.youtube.com/embed/${this.props.youtube_id}`} />
            </div>
            <div className="video-footer-cta">
              Want to code your own product? <strong>Join Le Wagon <a href="http://lewagon.com/program" target="_blank">FullStack program</a></strong>
              <a className="cover-link" href="http://lewagon.com/program" target="_blank"></a>
            </div>
          </div>
        </div>
      )
    }
    return(
      <div>
        <div className='batch-detail-header' style={coverStyle}>
          <div className='batch-detail-name'>
            Batch #{this.props.slug}
          </div>
          <div className='batch-detail-header-footer'>
            <div className='batch-detail-dates batch-detail-footer-item '>
              {this.props.starts_at} - {this.props.ends_at}
            </div>
            <div className='batch-detail-city batch-detail-footer-item '>
              {this.props.city}
            </div>
          </div>
        </div>
        <div className='batch-detail-body'>
          <main className='batch-detail-main'>
            {demoDay}
            <div className='batch-members-count section-title'>
              <i className='mdi mdi-cube-outline' />
              <div className='section-title-h'>{this.props.projects.length} PRODUCTS</div>
            </div>

            <div className='projects-list'>
              {this.props.projects.map(
                (project) => {
                  var projectThumbnailStyle = {
                    background: 'url(' + project.thumbnail_url + ')',
                    backgroundSize: 'cover',
                    backgroundPosition: 'center center',
                    backgroundColor: 'rgba(0, 0, 0, 0.02)'
                  }
                  return (
                    <div>
                    <a href={Routes.project_path(project.id)}>
                      <div className='project-item'>
                        <div className='project-thumbnail' style={projectThumbnailStyle} />
                        <div className='project-item-infos'>
                          <div className='project-item-name'>
                            {project.name}
                          </div>
                          <div className='project-item-tagline'>
                            {project.tagline_en}
                          </div>
                        </div>
                        <div className='project-item-makers'>
                          {project.makers.map(
                            (maker) => {
                              return(
                                <div className='project-item-maker'>
                                  <img src={maker.thumbnail} className='avatar' />
                                </div>
                              )
                            }
                          )}
                        </div>
                      </div>
                    </a>
                    {project.milestones.map(
                      (milestone) => {return (
                        <div className='milestone-item-container'>
                          <div className='milestone-item-date'>
                            {milestone.date}
                          </div>
                          <MilestoneListElement {...milestone} />
                        </div>
                      )}
                    )}
                    </div>
                  )
                }
              )}
            </div>
          </main>

          <aside className={sideBarClasses} style={sidebarStyle}>
            <div className='batch-members-count section-title'>
              <i className='mdi mdi-account-outline' />
              <div className='section-title-h'>{this.props.students.length} STUDENTS</div>
            </div>
            {this.props.students.map(student => {
              var participantClasses = classNames({
                'post-detail-participant': true,
                'is-offline': !student.connected_to_slack
              })
              return (
                <a href={Routes.profile_path(student.github_nickname)} className={participantClasses} key={student.id}>
                  <div className='post-detail-participant-avatar'>
                    <img src={student.thumbnail} className='avatar' />
                  </div>
                  <div className='post-detail-participant-name'>
                    {student.first_name}
                  </div>
                  <div className='post-detail-participant-status' />
                </a>
              )
            })}
            <div onClick={this.handleSidebarOpening.bind(this)} className='batch-detail-sidebar-viewmore'>
              <i className='mdi mdi-playlist-plus' />  MORE STUDENTS
            </div>
          </aside>
        </div>
      </div>
    )
  }

  componentDidMount() {
    var mainHeight = this._heightOf("batch-members-count") + this._heightOf('projects-list')
    if (this._heightOf('batch-detail-side-bar') > mainHeight && this.props.projects > 5 ) {
      this.setState({
        sidebarHeight: mainHeight
      })
    }
  }

  handleSidebarOpening() {
    this.setState({ sidebarHeight: '100%'})
  }

  _heightOf(klass) {
    return document.getElementsByClassName(klass)[0].scrollHeight
  }
}
