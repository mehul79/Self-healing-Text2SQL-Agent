"use client";

import { useState } from "react";
import { CheckIcon, CopyIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

// Placeholders, not real credentials: the user fills them in before running it as the DB owner.
const SNIPPET = `CREATE ROLE readonly_user WITH LOGIN PASSWORD '<strong_password>';
GRANT CONNECT ON DATABASE <your_database> TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user;`;

export function ReadOnlyRoleHelp() {
  const [copied, setCopied] = useState(false);

  async function copy() {
    await navigator.clipboard.writeText(SNIPPET);
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-sm">Connect with a read-only role</CardTitle>
      </CardHeader>
      <CardContent className="flex flex-col gap-3 text-sm text-muted-foreground">
        <p>
          Don&apos;t connect with your owner login. Run this as the owner, then use{" "}
          <code>readonly_user</code> here. Queries also run in read-only transactions, but a role that
          can only SELECT is the safer boundary.
        </p>
        <pre className="overflow-x-auto rounded-md bg-muted p-3 font-mono text-xs text-foreground">{SNIPPET}</pre>
        <Button variant="secondary" size="sm" className="self-start" onClick={copy}>
          {copied ? <CheckIcon /> : <CopyIcon />}
          {copied ? "Copied" : "Copy SQL"}
        </Button>
      </CardContent>
    </Card>
  );
}
