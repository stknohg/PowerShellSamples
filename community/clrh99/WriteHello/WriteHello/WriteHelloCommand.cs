using System;
using System.Management.Automation;

namespace WriteHello
{
    [Cmdlet("Write","Hello")]
    public class WriteHelloCommand : Cmdlet
    {
        [Parameter(Mandatory = true, ValueFromPipeline = true, Position = 1)]
        public string Message { get; set; }

        protected override void BeginProcessing()
        {
            base.WriteVerbose("Begin Cmdlet...");
        }

        protected override void ProcessRecord()
        {
            base.WriteVerbose(string.Format("Process input value {0}...", this.Message));
            base.WriteObject(string.Format("Hello {0}!", this.Message));
        }

        protected override void EndProcessing()
        {
            base.WriteVerbose("End Cmdlet.");
        }
    }
}
