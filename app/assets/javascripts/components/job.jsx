class Job extends React.Component {
  render() {
    if (this.props.ad_url != undefined) {
      var learnMore = (
                        <a href={this.props.ad_url}>
                          <div className='post-detail-url'>
                            Learn more
                          </div>
                        </a>
                      )
    }

    if (this.props.contact_email != undefined) {
      var contactEmail = (
                          <a href={`mail_to:${this.props.contact_email}`}>
                            <div className='post-detail-url'>
                              {this.props.contact_email}
                            </div>
                          </a>
                         )
    }
    return (
      <div className='post-detail'>
        <div className='post-detail-header job-detail'>
          <div className='container'>
            <div className='post-detail-name post-detail-name-reduce'>{this.props.company} <span className='text-readable'>is hiring a</span> {this.props.title} <span className='text-readable'>in</span> {this.props.city}</div>
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
