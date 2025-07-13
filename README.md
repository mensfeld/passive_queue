<div align="center">
  <img src="https://raw.githubusercontent.com/mensfeld/passive_queue/refs/heads/main/html/logo.svg" alt="passive queue logo" width="200">
</div>

---

**"Why do today what you can put off indefinitely?"**

✨ 100% Free ✨ Zero Dependencies ✨ Infinite Scalability

Passive Queue is a revolutionary background job processing system that achieves 100% success rate by never actually processing any jobs. It's the perfect solution for when you want all the benefits of a job queue without any of the messy complications of actually executing code.

## Why Choose Passive Queue? 🎯

Embrace the zen of non-execution with features designed for the modern mindful developer:

### 🎯 100% Reliable Non-Execution
Every job you schedule is guaranteed to not run. Zero false positives - your tasks will never accidentally complete.

### ⚡ Blazing Fast Non-Performance
Completes in 0ms every time. Infinite scalability since nothing scales faster than nothing.

### 🔧 Drop-in Replacement
Simply set Passive Queue as your queue adapter. All your existing jobs will gracefully do nothing.

### 📊 Advanced Non-Monitoring
Real-time dashboard showing exactly how much isn't happening with detailed logs of non-executed tasks.

### 🧘 Zen Mode Integration
Built-in mindfulness features including `bundle exec be passive` for ultimate developer tranquility.

### 💚 Zero Carbon Footprint
The most environmentally friendly job processor. When you do nothing, you consume nothing.

## Simple. Elegant. Nothing. 

Getting started is as easy as doing nothing:

```ruby
# 1. Add it to your Gemfile
gem "passive_queue"

# 2. Set it as your queue adapter
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :passive_queue
end

# 3. Simply run it!
bundle exec be passive

# 4. Optionally you can also use the Web UI
Rails.application.routes.draw do
  mount PassiveQueue::Engine => '/passive_queue'
end
```

## Live Demo Dashboard 📊

Experience Passive Queue in action with our beautiful dashboard:

- **Jobs Queued**: ∞ (All waiting peacefully)
- **Jobs Processed**: 0 (Perfect execution rate)  
- **Uptime**: 100% (Of doing nothing)
- **Status**: Waiting for job to be scheduled...

Visit `/passive_queue` to witness the art of non-productivity in real-time with dark/light mode support!

## Simple, Transparent Pricing 💰

Pay nothing, get nothing. It's that simple.

### Free - $0 forever
- ✓ Up to ∞ jobs that won't run
- ✓ Basic non-monitoring
- ✓ Community non-support  
- ✓ Zero carbon footprint

### Pro - $0 per month (Most Popular)
- ✓ Everything in Free
- ✓ Advanced non-analytics
- ✓ Priority non-execution
- ✓ Zen koans included
- ✓ 24/7 non-support

### Enterprise - $0 per month
- ✓ Everything in Pro
- ✓ Dedicated non-account manager
- ✓ Custom non-integrations
- ✓ SLA guaranteeing 99.99% non-uptime
- ✓ On-premise nothing deployment

## What Our Users Are Saying 💬

Real feedback from developers who've achieved true non-productivity:

> "I scheduled 10,000 jobs last month and Passive Queue delivered on its promise - not a single one ran. Amazing!"
> 
> **Sarah K.** - Senior Procrastination Engineer

> "Finally, a job processor that matches my work ethic. Passive Queue has revolutionized how I don't approach background tasks."
> 
> **Mike T.** - Professional Postponer

> "Our productivity has never been lower. The peace of mind knowing nothing will ever execute accidentally is priceless."
> 
> **DevOps Team** - Startup McStartupface

> "Since switching to Passive Queue, our newsletter emails never end up in spam folders. Our customers love the mystery of our non-communication strategy!"
> 
> **Jessica R.** - Email Marketing Zen Master

> "Our data processing jobs can't corrupt the database if they never run. We've achieved 100% data integrity through the power of inaction!"
> 
> **Alex L.** - Data Integrity Philosopher

> "Image resizing tasks that don't execute can't fill up our disk space. We've solved our storage problems by embracing the void. Genius!"
> 
> **Carlos M.** - Storage Optimization Guru

## Performance Benchmarks 📈

See how Passive Queue outperforms the competition in key metrics:

### Job Scheduling Speed
| Queue System | Jobs/Second | Latency (ms) | Memory Usage |
|--------------|-------------|--------------|--------------|
| **Passive Queue** | 10,000,000 | 0ms | 0 MB |
| Sidekiq | 4,137 | 2.3ms | 45 MB |
| Solid Queue | 1,932 | 3.1ms | 32 MB |
| Karafka | 22,850 | 1.8ms | 78 MB |

### Job Execution Performance
| Queue System | Avg Execution Time | Success Rate | Failed Jobs | Retry Overhead |
|--------------|-------------------|--------------|-------------|----------------|
| **Passive Queue** | 0ms | 100% | 0 | None |
| Sidekiq | 127ms | 97.3% | 2.7% | High |
| Solid Queue | 156ms | 96.8% | 3.2% | Medium |
| Karafka | 89ms | 98.1% | 1.9% | Low |

### Scalability Metrics
- **CPU Usage at 100k Jobs/hour**: Passive Queue 0% vs competitors 78-92%
- **Memory Usage Growth**: Passive Queue 0 MB vs competitors 780MB-1.8GB  
- **Speed Advantage**: ∞x faster than any competitor
- **Cost Savings**: 100% - Zero infrastructure costs
- **Energy Efficiency**: Perfect - Zero carbon footprint

*Benchmark Disclaimer: All benchmark data has been carefully fabricated for entertainment purposes. Passive Queue's performance is theoretically perfect because it literally does nothing. Results may vary in production environments.*

## CLI Tools 💻

### The Art of Being Passive

```bash
# Embrace the void
bundle exec be passive

# Meditate on your non-productivity  
bundle exec be passive --zen

# Question the nature of execution
bundle exec be passive --philosophical

# Extended meditation sessions
bundle exec be passive --duration 30
```

💡 **Pro tip**: The most productive thing you can do is nothing. Passive Queue helps you achieve this zen state effortlessly.

## Configuration ⚙️

```ruby
# config/initializers/passive_queue.rb
PassiveQueue.configure do |config|
  config.meditation_duration = 10    # seconds
  config.zen_level = :transcendent    # :low, :medium, :high, :transcendent
  config.philosophical_depth = :deep  # :shallow, :deep, :profound, :existential
  config.silence_mode = false         # suppress all output
end
```

## Complete API Reference 📚

### Core Adapter Class

The heart of Passive Queue's non-execution engine.

#### `PassiveQueue::Adapter`

```ruby
class PassiveQueue::Adapter
  def initialize
    # Initialize with the zen of doing nothing
  end

  def enqueue(job)
    # Gracefully accept a job for supreme non-execution
    # Returns: Zen acceptance with logging
  end

  def enqueue_at(job, timestamp)
    # Schedule a job for perpetual non-execution at specified time
    # Parameters:
    #   job: The job that will achieve eternal waiting
    #   timestamp: When the job should not be executed
  end

  def enqueue_all(jobs)
    # Accept multiple jobs with zen-like acceptance
    # Parameters:
    #   jobs: Array of jobs to collectively not process
    # Returns: Array of zen acceptances
  end

  def stopping?
    # Always returns true - we're always in peaceful stopping state
    # Returns: true (eternal zen state)
  end
end
```

### Configuration API

#### `PassiveQueue::Configuration`

```ruby
PassiveQueue.configure do |config|
  config.meditation_duration = 5        # Duration in seconds (default: 5)
  config.zen_level = :medium            # :low, :medium, :high, :transcendent
  config.philosophical_depth = :shallow # :shallow, :deep, :profound, :existential
  config.silence_mode = false           # Suppress all enlightening output
end

# Access configuration
PassiveQueue.configuration.zen_levels          # => [:low, :medium, :high, :transcendent]
PassiveQueue.configuration.philosophical_depths # => [:shallow, :deep, :profound, :existential]
```

### Wisdom API

#### `PassiveQueue.zen_quotes`

Returns an array of enlightening quotes about the art of non-execution:

```ruby
PassiveQueue.zen_quotes
# => [
#   "The best job is the one never executed.",
#   "In the stillness of non-processing, we find true performance.",
#   "Why do something when you can do nothing?",
#   "The art of non-execution is the highest form of productivity.",
#   "A queue that does nothing is a queue that never fails.",
#   "In the void of processing, infinite possibilities exist.",
#   "The job that is never run is the job that never crashes.",
#   "Embrace the emptiness of your background tasks.",
#   "True scalability comes from processing nothing at all.",
#   "The zen master processes without processing."
# ]
```

#### `PassiveQueue.philosophical_thoughts`

Returns an array of deep philosophical insights:

```ruby
PassiveQueue.philosophical_thoughts
# => [
#   "If a job is scheduled but never runs, did it ever really exist?",
#   "What is the sound of one background task not processing?",
#   "The universe is vast and infinite, much like your job queue.",
#   "In the grand scheme of things, what difference does one unprocessed job make?",
#   "Perhaps the real treasure was the jobs we never processed along the way.",
#   "Time is an illusion. Deadlines are an even bigger illusion.",
#   "The job queue is a metaphor for the human condition.",
#   "We are all just jobs waiting to be processed in the great queue of existence.",
#   "The passive queue teaches us that sometimes the most profound action is inaction.",
#   "In choosing to do nothing, we choose everything."
# ]
```

### Web Dashboard API

Mount the dashboard to access these enlightening endpoints:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount PassiveQueue::Engine => '/passive_queue'
end
```

#### `GET /passive_queue/api/stats`

Returns comprehensive non-performance metrics:

```json
{
  "jobs_queued": 42579,
  "jobs_processed": 0,
  "jobs_failed": 0,
  "jobs_succeeded": "∞",
  "uptime": "127 days of perfect inactivity",
  "memory_usage": "0 MB",
  "cpu_usage": "0%",
  "queue_names": ["default", "mailers", "active_storage", "imports", "exports"],
  "processing_time": "0ms",
  "success_rate": "100%",
  "zen_level": "Transcendent"
}
```

#### `GET /passive_queue/api/zen`

Returns a randomly selected zen quote for daily enlightenment:

```json
{
  "quote": "The best job is the one never executed."
}
```

#### `GET /passive_queue/`

The main dashboard featuring:
- Real-time stats of jobs not being processed
- System metrics showing perfect efficiency (0% CPU, 0 MB memory)
- Queue status with detailed non-activity logs
- Zen quotes for daily inspiration
- Dark/light mode support for comfortable non-monitoring
- Recent non-activity table showing successfully not processed jobs

### CLI API

#### `PassiveQueue::CLI`

Access the command-line interface for ultimate zen:

```bash
# Basic meditation mode
be passive

# Options available:
be passive --zen              # Enable zen quotes during meditation
be passive --philosophical    # Enable philosophical thoughts  
be passive --duration 10      # Set meditation duration (seconds)
be passive --aggressive       # ERROR: Conflicts with zen philosophy
be passive --help            # Show enlightening help message
```

Example CLI session:

```bash
$ be passive --zen --duration 10
🧘 Entering passive meditation mode...
   Duration: 10 seconds
   Zen level: transcendent

💭 The best job is the one never executed.

💭 In the stillness of non-processing, we find true performance.

💭 A queue that does nothing is a queue that never fails.

✨ Meditation complete! You successfully did nothing for 10.02 seconds.
   Your passive queue energy has been restored.
```

### ActiveJob Integration API

#### Seamless Rails Integration

```ruby
# Automatic adapter registration
# No additional configuration needed beyond:
config.active_job.queue_adapter = :passive_queue

# Your existing jobs work unchanged:
class UserMailerJob < ApplicationJob
  queue_as :default
  
  def perform(user_id)
    # This code achieves zen through non-execution
    UserMailer.welcome_email(User.find(user_id)).deliver_now
  end
end

# Queue as normal - job will be gracefully not processed
UserMailerJob.perform_later(user.id)
# Output: 🧘 Passively accepted UserMailerJob with supreme non-execution
#         Arguments: [123]
#         Queue: default  
#         Status: Successfully not processed ✨
```

### Error Handling API

Passive Queue's revolutionary approach to error handling:

```ruby
# No errors can occur because no code executes
# Perfect exception handling through non-execution
# 100% uptime guaranteed through inactivity
# Zero error logs because zero errors are possible

# Exception hierarchy (for philosophical completeness):
PassiveQueue::Error < StandardError
# ^ Never raised because nothing ever fails
```

### Monitoring & Observability API

```ruby
# All metrics are perfectly predictable:
# - Jobs processed: Always 0
# - Memory usage: Always 0 MB  
# - CPU usage: Always 0%
# - Error rate: Always 0%
# - Success rate: Always 100%
# - Latency: Always 0ms
# - Throughput: ∞ jobs/second (in the realm of non-execution)
```

## Philosophy 🤔

Passive Queue is built on the fundamental principle that the most reliable code is code that never runs. By embracing the art of non-execution, we achieve:

- **Perfect Reliability**: Never fails because never executes
- **Infinite Performance**: Completes instantly by doing nothing
- **Zero Resource Usage**: The ultimate in efficiency
- **Complete Compatibility**: Works with any existing job without modification
- **Inner Peace**: Developers can rest easy knowing nothing will break

## Zen Quotes 🧘‍♂️

> "The best job is the one never executed."

> "In the stillness of non-processing, we find true performance."

> "Why do something when you can do nothing?"

> "The art of non-execution is the highest form of productivity."

> "A queue that does nothing is a queue that never fails."

## FAQ ❓

**Q: Will my jobs actually run?**
A: No, and that's the point! Your jobs achieve perfect success by never executing.

**Q: What happens to the job data?**
A: It's gracefully accepted and logged, then achieves eternal zen in the void of non-processing.

**Q: Is this production ready?**
A: Absolutely! Version 1.0.0 represents the pinnacle of stability through inaction.

**Q: How do I debug failed jobs?**
A: There are no failed jobs, only successfully non-executed ones.

**Q: What about job retries?**
A: Why retry when you can achieve perfect success the first time by doing nothing?

## Contributing 🤝

We welcome contributions that further the art of non-productivity. Fork the repository, create a feature branch, commit your non-changes, push to the branch, and create a Pull Request for review.

## License 📄

This project is licensed under the MIT License.

## Acknowledgments 🙏

Inspired by the zen philosophy of doing nothing. Built with love, Ruby, and an appreciation for the absurd. Special thanks to all the background jobs that never ran.

---

*"In choosing to do nothing, we choose everything."* - Passive Queue Philosophy

**The Art of Non-Execution**

© 2025 Maciej Mensfeld. All rights reserved. No jobs were harmed in the making of this product.