class PostDetailFooter extends React.Component {
  render() {
    return (
      <div className='post-detail-footer'>
        <main className='post-detail-form'>
          <AnswerForm post_id={this.props.id} type={this.props.type} />
        </main>
        <aside className='post-detail-author'>
          <img src={this.props.user.gravatar_url} className='avatar' />
          <span className='post-detail-author-date'>POSTED {this.props.time_ago_in_word} AGO</span>
        </aside>
      </div>
    )
  }
}
