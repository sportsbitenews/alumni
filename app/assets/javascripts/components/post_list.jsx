class PostList extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      resources: props.resources,
      questions: props.questions,
      jobs: props.jobs,
      milestones: props.milestones
    };

    this.onStoreChange = this.onStoreChange.bind(this);
  }

  componentDidMount() {
    PostStore.listen(this.onStoreChange);
  }

  onStoreChange(store) {
    this.setState({
      resources: store.posts.resources,
      questions: store.posts.questions,
      jobs: store.posts.jobs,
      milestones: store.posts.milestones,
    });
  }

  render() {
    return (
      <div ref='postList'>
        <SwipeViews>
          <div className='col-sm-3 posts-column' title="#resources">
          <a href={Routes.new_resource_path()}>
            <div className='posts-column-new'>
              ADD A NEW RESOURCE
            </div>
          </a>
            {this.state.resources.map(resource => {
              var props = _.merge(resource, { key: `${resource.type}-${resource.id}` });
              return React.createElement(ResourceListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#help">
          <a href={Routes.new_question_path()}>
            <div className='posts-column-new'>
              ASK A NEW QUESTION
            </div>
          </a>
            {this.state.questions.map(question => {
              var props = _.merge(question, { key: `${question.type}-${question.id}` });
              return React.createElement(QuestionListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#jobs">
            <a href={Routes.new_job_path()}>
              <div className='posts-column-new'>
                ADD A NEW JOB
              </div>
            </a>
            {this.state.jobs.map(job => {
              var props = _.merge(job, { key: `${job.type}-${job.id}` });
              return React.createElement(JobListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#milestones">
            <a href={this.props.current_user.can_post_milestone ? Routes.new_milestone_path() : 'mailto:seb@lewagon.org'}>
            <div className='posts-column-new'>
            {this.props.current_user.can_post_milestone ? 'ADD A NEW MILESTONE' : 'SUBMIT A NEW PRODUCT'}
            </div>
            </a>
            {this.state.milestones.map(milestone => {
              var props = _.merge(milestone, { key: `${milestone.type}-${milestone.id}` });
              return React.createElement(MilestoneListElement, props);
            })}
          </div>
        </SwipeViews>
      </div>
    );
  }
}
