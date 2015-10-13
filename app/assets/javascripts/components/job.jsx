class Job extends React.Component {
  render() {
    if (this.props.ad_url != "") {
      var learnMore = (
                        <a href={this.props.ad_url} target='_blank'>
                          <div className='post-detail-url'>
                            <i className='mdi mdi-link' />&nbsp;Learn more
                          </div>
                        </a>
                      )
    }

    if (this.props.contact_email != "") {
      var contactEmail = (
                          <a href={`mailto:${this.props.contact_email}`}>
                            <div className='post-detail-url'>
                              <i className='mdi mdi-email-outline' />&nbsp;Apply
                            </div>
                          </a>
                         )
    }

    if (this.props.city != "") {
      var inCity = (
        <span><span className='text-readable'>in</span> {this.props.city}</span>
      );
    } else {
      var remote = 'remote';
    }
    return (
      <div className='post-detail'>
        <div className='post-detail-header job-detail'>
          <div className='post-detail-header-main'>
            <div className='post-detail-name post-detail-name-reduce'>{this.props.company} <span className='text-readable'>is hiring a {remote}</span> {this.props.title} {inCity} </div>
            <div className='post-detail-header-action'>
              <div className='post-detail-upvote'>
                <Upvote {...this.props} />
              </div>
              {contactEmail}
              {learnMore}
            </div>
          </div>
        </div>
        <PostDetailBody {...this.props} />
        <PostDetailFooter {...this.props} />
      </div>
    )
  }
}
